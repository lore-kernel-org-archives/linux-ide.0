From: Andrew Morton <akpm@osdl.org>
Subject: Re: linux 2.6.9 controller order reordered.  was: [Re: linux 2.6.9
 still having network code problems]
Date: Tue, 2 Nov 2004 02:07:12 -0800
Message-ID: <20041102020712.18218d47.akpm@osdl.org>
References: <418741EB.3080701@outblaze.com>
	<20041102011918.2b453e21.akpm@osdl.org>
	<4187478A.1040002@outblaze.com>
	<20041102014119.1a6096cc.akpm@osdl.org>
	<41874D93.9000008@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:49845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264402AbUKBJJF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2004 04:09:05 -0500
In-Reply-To: <41874D93.9000008@outblaze.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christopher Chan <cchan@outblaze.com>
Cc: linux-ide@vger.kernel.org

Christopher Chan <cchan@outblaze.com> wrote:
>
> Andrew Morton wrote:
> > Christopher Chan <cchan@outblaze.com> wrote:
> > 
> >>DOH. the kernel swapped the controller order on me...fstab entries 
> >> referred to the wrong device names...
> > 
> > 
> > Eh?  That shouldn't happen.  Could you please generate a full report of
> > this, send it to the appropriate list and cc myself?
> > 
> > Although if that's the 2.6.9 behaviour it's probably a bit late to fix it
> > up.
> > 
> 
> Hardware: Tyan mb with Serverworks chipset and onboard Promise controller.
> 	The two disks on promise channel since Serverworks does not support ATA100
> 
> FC2 Installation will recognise the disks as hde and hdg
> fstab is accordingly setup as so for swap (everything else are md)
> 
> Changing to a 2.6.9 kernel that has the promise driver compiled in will 
> change the disks to hda and hdc.

Could you send the dmesg output so we can see the probing activity?
