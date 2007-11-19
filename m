From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 09:47:03 +1100 (EST)
Message-ID: <625522.94543.qm@web52604.mail.re2.yahoo.com>
References: <200711141746.26793.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52604.mail.re2.yahoo.com ([206.190.48.207]:42969 "HELO
	web52604.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752400AbXKSWrG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 17:47:06 -0500
In-Reply-To: <200711141746.26793.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
[...]
> 
> IOMMU merging should be always safe. If it is not the driver should
> not submit things in a single SG list.
> 
> > So the main option 
> > right now seems to revert the iommu_merge patch.
> 
> I don't think that is the correct fix.

Just to make sure this problem doesn't fall off the radar screen, I've filed
it on Kernel Bugzilla: 
http://bugzilla.kernel.org/show_bug.cgi?id=9412

Thanks



      Feel safe with award winning spam protection on Yahoo!7 Mail.  
www.yahoo.com.au/mail 

