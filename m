From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Tue, 05 Feb 2008 07:47:07 +0000
Message-ID: <47A8228B.76E4.0078.0@novell.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
 <47A71538.50803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18174
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbYBEHqq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Feb 2008 02:46:46 -0500
In-Reply-To: <47A71538.50803@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>Yes, we can be more smart if necessary.  I don't know.  The hardware is
>clearly violating the spec which requires those two values to agree.

So are you saying the ESB2 spec is violating a higher level spec? I know
almost nothing about AHCI, so please forgive that question...

>What status values are you seeing?  Hardware vendors usually don't get
>n_ports wrong from the start, they probably have forgotten to decrement
>it by one when one of the ports is plugged for some reason.  I bet the
>silicon for the port is there and reporting offline PHY, right?

This is output from our SLE10SP2 kernel, the output is similar for others:

<6>scsi2 : ahci
<6>ata3: SATA link down (SStatus 0 SControl 300)
<6>scsi3 : ahci
<6>ata4: SATA link down (SStatus 0 SControl 300)
<6>scsi4 : ahci
<6>ata5: SATA link down (SStatus 4 SControl 300)
<6>scsi5 : ahci
<6>ata6: SATA link down (SStatus 0 SControl 0)

Even the message relating to ata5 seems a little dubious to me, as it's
not in sync with what the other unused ports say (and also not in sync
with what I see on other boxes - SStatus is always 0 for such ports).

Jan

