From: Jeff Garzik <jeff@garzik.org>
Subject: Re: WARNING at libata-core.c:5015 in 2.6.39-rc3-wl+, then lockup.
 (bisected)
Date: Fri, 15 Apr 2011 13:57:27 -0400
Message-ID: <4DA88707.4060704@garzik.org>
References: <4DA5CF81.4070908@candelatech.com> <4DA5D5D8.8070301@candelatech.com> <4DA5F3BA.3060404@candelatech.com> <4DA87A72.50809@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DA87A72.50809@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Greear <greearb@candelatech.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 04/15/2011 01:03 PM, Ben Greear wrote:
> Ok, it took a while, but I think I have this thing somewhat bisected.
>
> Starting at commit 4cc4d24efce4672f9b0e7fa27963770ae602998f, I see
> hard-drive
> issues. Commits right before this (in git bisect) crash in the
> networking code
> quite often, but the hard-drive logic seems to work at least.
>
> In later builds (ie, -rc3), the crashes and warnings are different, but
> they have something to do with the file system. It's difficult to bisect
> it any better because of all the instability...
>
>
> Here are some console logs from a
> 4cc4d24efce4672f9b0e7fa27963770ae602998f boot:

(linux-ide added to CC)

hmmm...  that's a merge commit.  Any chance you could mark an individual 
commit bad, to narrow things down a bit more?  Run "git help bisect" and 
check out helpful sections "Avoiding testing a commit" and "Bisect skip".

	Jeff
