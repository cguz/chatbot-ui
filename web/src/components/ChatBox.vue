<template>
    <div class="sticky bottom-0 right-0 left-0 p-0 w-96">
        <div v-if="loading" class="flex items-center justify-center w-full">
            <div class="flex flex-row p-2 rounded-t-lg ">

                <button type="button"
                    class="bg-bg-light-tone-panel dark:bg-bg-dark-tone-panel hover:bg-bg-light-tone focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:hover:bg-bg-dark-tone focus:outline-none dark:focus:ring-blue-800"
                    @click.stop="stopGenerating">
                    Stop generating
                </button>
            </div>
        </div>
        <form>
            <label for="chat" class="sr-only">Send message</label>
            <div
                class="px-3 py-3 rounded-t-lg bg-bg-light-tone-panel dark:bg-bg-dark-tone-panel shadow-lg  ">
                <!-- FILES     -->
                <div class="flex flex-col flex-grow">
                    <div v-if="fileList.length>0" class="flex flex-row overflow-x-scroll mb-2 gap-1 scrollbar-thin scrollbar-track-bg-light-tone-panel scrollbar-thumb-bg-light-tone-panel hover:scrollbar-thumb-primary dark:scrollbar-track-bg-dark-tone dark:scrollbar-thumb-bg-dark-tone-panel dark:hover:scrollbar-thumb-primary active:scrollbar-thumb-secondary">
                        <TransitionGroup name="list" tag="div" class="flex flex-row items-center p-2">
                        <div v-for="file in fileList" :key="file.name">
                            <div class="relative m-1 cursor-pointer">

                                <span
                                    class="inline-flex items-center px-2 py-1 mr-2 text-sm font-medium bg-bg-dark-tone-panel dark:bg-bg-dark-tone rounded-lg hover:bg-primary-light ">
                                    <i data-feather="file" class="w-5 h-5 mr-1 truncate"></i>
                                    {{ file.name }}
                                    ({{ computedFileSize(file.size) }})
                                    <button type="button" title="Remove item"
                                        class="inline-flex items-center p-0.5 ml-2 text-sm rounded-sm hover:text-red-600 active:scale-75"
                                        @click="removeItem(file)">
                                        <i data-feather="x" class="w-5 h-5 "></i>

                                    </button>
                                </span>


                            </div>
                        </div>
                    </TransitionGroup>
                        
                    </div>

                    <div class="flex flex-row flex-grow items-center gap-2 ">

                    
                    <textarea id="chat" rows="1" v-model="message"
                        class="block min-h-11  no-scrollbar  p-2.5 w-full text-sm text-gray-900 bg-bg-light rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-bg-dark dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        placeholder="Send message..." @keydown.enter.exact="submitOnEnter($event)"></textarea>

                    <!-- BUTTONS -->
                    <div class="inline-flex justify-center  rounded-full ">

                        <button v-if="!loading" type="button" @click="submit"
                            class=" w-6 hover:text-secondary duration-75 active:scale-90">

                            <i data-feather="send"></i>

                            <span class="sr-only">Send message</span>
                        </button>
                        <div v-if="loading" title="Waiting for reply">
                            <!-- SPINNER -->
                            <div role="status">
                                <svg aria-hidden="true" class="w-6 h-6   animate-spin  fill-secondary" viewBox="0 0 100 101"
                                    fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                                        fill="currentColor" />
                                    <path
                                        d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                                        fill="currentFill" />
                                </svg>
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </form>
    </div>
</template>
<style scoped>
/* THESE ARE FOR TransitionGroup components */
.list-move,
/* apply transition to moving elements */
.list-enter-active,
.list-leave-active {
    transition: all 0.5s ease;
}

.list-enter-from {
    transform: translatey(-30px);
}

.list-leave-to {
    opacity: 0;
    transform: translatey(30px);
}

/* ensure leaving items are taken out of layout flow so that moving
   animations can be calculated correctly. */
.list-leave-active {
    position: absolute;
}
</style>

<script>
import { nextTick,TransitionGroup } from 'vue'
import feather from 'feather-icons'
import filesize from '../plugins/filesize'
export default {
    name: 'ChatBox',
    emits: ["messageSentEvent", "stopGenerating"],
    props: {

        loading: false

    },
    setup() {
        return {}
    },
    data() {
        return {
            message: "",
            fileList:[]
        }
    },
    methods: {
        computedFileSize(size) {
            return filesize(size)
        },
        removeItem(file) {
            this.fileList = this.fileList.filter((item) => item != file)
            // console.log(this.fileList)
        },
        sendMessageEvent(msg) {

            this.$emit('messageSentEvent', msg)

        },
        submitOnEnter(event) {
            if (event.which === 13) {
                event.preventDefault(); // Prevents the addition of a new line in the text field

                if (!event.repeat) {

                    this.sendMessageEvent(this.message)
                    this.message = "" // Clear input field
                }

            }
        },
        submit() {
            if (this.message) {
                this.sendMessageEvent(this.message)
                this.message = ""
            }

        },
        stopGenerating() {
            this.$emit('stopGenerating')
        }
    },
    watch: {
        loading(newval, oldval) {
            nextTick(() => {
                feather.replace()
            })
        }
    },
    mounted() {
        nextTick(() => {
            feather.replace()
        })
    },
    activated() {

    }
}
</script>
