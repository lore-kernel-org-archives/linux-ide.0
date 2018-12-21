From: Philip Li <philip.li@intel.com>
Subject: Re: [LKP] [ide] ec7d9c9ce8:
 WARNING:at_fs/proc/generic.c:#remove_proc_entry
Date: Fri, 21 Dec 2018 09:53:52 +0800
Message-ID: <20181221015352.GA7734@intel.com>
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com>
 <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, lkp@01.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 20, 2018 at 08:05:28AM -0800, Linus Torvalds wrote:
> On Thu, Dec 20, 2018 at 1:19 AM kernel test robot <lkp@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: ec7d9c9ce897174243af4fcd201dbfc34df0f3a3 ("ide: replace ->proc_fops with ->proc_show")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Funky.  How did the kernel test robot suddenly figure out an 8-month
> old problem?
Hi Linus, sorry for this late report. I can't figure out exact reason but some possible clues.

The issue is captured by rcutoture which doesn't work well before. And only from late october,
we have solved a few issues of the execution including the rootfs (yocto) it is using. And this issue
is against an randconfig, i'm not sure whether the issue depends on a certain kconfig thus only
be triggered or successfully bisected this time.

> 
> > [   44.180514] WARNING: CPU: 1 PID: 165 at fs/proc/generic.c:662 remove_proc_entry+0xb9/0x155
> 
> This is a warning for somebody doing "remove_proc_entry() on a name
> that doesn't actually exist in that /proc directory.
> 
> In this case, it does seem to be due to the named commit adding a
> 
> +               remove_proc_entry("settings", drive->proc);
> 
> to ide_proc_unregister_device(), and looking at the patch I get the
> feeling that it's due to a typo: the code *creates* the file called
> "setting", but removes the file "settings". Note the missing "s" at
> creation time.
> 
> And yes, the name of the /proc file _should_be "settings", judging by
> the rest of the patch.
> 
> So it does seem to be a real bug. Nobody noticed until now? Why did
> the test robot suddenly react to it?
> 
>               Linus
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
