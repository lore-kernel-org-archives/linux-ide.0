From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ide] ec7d9c9ce8: WARNING:at_fs/proc/generic.c:#remove_proc_entry
Date: Thu, 20 Dec 2018 08:05:28 -0800
Message-ID: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, lkp@01.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 20, 2018 at 1:19 AM kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: ec7d9c9ce897174243af4fcd201dbfc34df0f3a3 ("ide: replace ->proc_fops with ->proc_show")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Funky.  How did the kernel test robot suddenly figure out an 8-month
old problem?

> [   44.180514] WARNING: CPU: 1 PID: 165 at fs/proc/generic.c:662 remove_proc_entry+0xb9/0x155

This is a warning for somebody doing "remove_proc_entry() on a name
that doesn't actually exist in that /proc directory.

In this case, it does seem to be due to the named commit adding a

+               remove_proc_entry("settings", drive->proc);

to ide_proc_unregister_device(), and looking at the patch I get the
feeling that it's due to a typo: the code *creates* the file called
"setting", but removes the file "settings". Note the missing "s" at
creation time.

And yes, the name of the /proc file _should_be "settings", judging by
the rest of the patch.

So it does seem to be a real bug. Nobody noticed until now? Why did
the test robot suddenly react to it?

              Linus
