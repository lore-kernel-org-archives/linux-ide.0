From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Status of the sata_sil driver for the VT8237
Date: Sat, 27 Mar 2004 22:16:56 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406643A8.2050808@pobox.com>
References: <4066342B.4080105@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262068AbUC1DRJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 22:17:09 -0500
In-Reply-To: <4066342B.4080105@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

J. Ryan Earl wrote:
> I was wondering, what is the state of the sata_sil driver for the VIA 
> VT8237 southbridge (ie the one used commonly on their K8T 
> motherboards).  Is this still beta?  Any known problems with it?

Well prior to the most recent version, calling it "beta" was putting it 
kindly.  I would call it broken :) which was why it was marked with 
CONFIG_BROKEN...

As of the most recent 2.6.5-rc2-bk snapshots, libata and sata_sil should 
be pretty happy with each other.

Some of the VIA problems were actually platform-related.  "noapic", 
"nomce", turning -on- local APIC support, and a few other workarounds 
have been found for these.

If you're on x86-64, make sure you have the latest BIOS version, too.

	Jeff




