From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Status of the sata_sil driver for the VT8237
Date: Sat, 27 Mar 2004 21:47:48 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40664AE4.8010003@clanhk.org>
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.clanhk.org ([69.93.101.154]:36526 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262077AbUC1Drl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2004 22:47:41 -0500
In-Reply-To: <406643A8.2050808@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> J. Ryan Earl wrote:
>
>> I was wondering, what is the state of the sata_sil driver for the VIA 
>> VT8237 southbridge (ie the one used commonly on their K8T 
>> motherboards).  Is this still beta?  Any known problems with it?
>
>
> Well prior to the most recent version, calling it "beta" was putting 
> it kindly.  I would call it broken :) which was why it was marked with 
> CONFIG_BROKEN...
>
> As of the most recent 2.6.5-rc2-bk snapshots, libata and sata_sil 
> should be pretty happy with each other.

I meant sata_via, I dunno why I said sata_sil; Freudian typo.  I was 
thinking of the current sii3112 I use, which has been stable and 
blazingly fast for awhile with the IDE driver--and a little little patch 
I keep applying.  I'm looking to upgrade a server with 2 Raptors in it 
to an A64 running 64-bit Linux of course.  I wanna get the HDs off the 
PCI bus and onto the VT8237 southbridge.  I was wondering if the driver 
for -that southbridge- was still considered beta.

-ryan
