From: Christopher Chan <cchan@outblaze.com>
Subject: linux 2.6.9 controller order reordered.  was: [Re: linux 2.6.9 still
 having network code problems]
Date: Tue, 02 Nov 2004 17:04:19 +0800
Message-ID: <41874D93.9000008@outblaze.com>
References: <418741EB.3080701@outblaze.com>	<20041102011918.2b453e21.akpm@osdl.org>	<4187478A.1040002@outblaze.com> <20041102014119.1a6096cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from corpmail.outblaze.com ([203.86.166.82]:50086 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S291441AbUKBJEE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Nov 2004 04:04:04 -0500
In-Reply-To: <20041102014119.1a6096cc.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>

Andrew Morton wrote:
> Christopher Chan <cchan@outblaze.com> wrote:
> 
>>DOH. the kernel swapped the controller order on me...fstab entries 
>> referred to the wrong device names...
> 
> 
> Eh?  That shouldn't happen.  Could you please generate a full report of
> this, send it to the appropriate list and cc myself?
> 
> Although if that's the 2.6.9 behaviour it's probably a bit late to fix it
> up.
> 

Hardware: Tyan mb with Serverworks chipset and onboard Promise controller.
	The two disks on promise channel since Serverworks does not support ATA100

FC2 Installation will recognise the disks as hde and hdg
fstab is accordingly setup as so for swap (everything else are md)

Changing to a 2.6.9 kernel that has the promise driver compiled in will 
change the disks to hda and hdc.
