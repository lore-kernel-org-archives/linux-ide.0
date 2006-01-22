From: Chase Venters <chase.venters@clientec.com>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sun, 22 Jan 2006 13:46:02 -0600
Message-ID: <200601221346.25154.chase.venters@clientec.com>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <200601221317.17124.chase.venters@clientec.com> <1137957890.3328.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay03.pair.com ([209.68.5.17]:36868 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751322AbWAVTq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 14:46:27 -0500
In-Reply-To: <1137957890.3328.41.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 22 January 2006 13:24, Arjan van de Ven wrote:
> and you're not using nvidia either? can you see if you have
> modules/drivers in common with this reporter to see if there maybe are
> common suspects?

No - I am tainting with NVIDIA unfortunately. I was trying to find the time to 
diagnose sans NVIDIA when Anton reported the same leak (turns out he has the 
same Asus P5GDC-V Deluxe board), only in his dmesg he is not tainting at all.

We did determine that Anton and I both use the Marvell sk98lin patch for our 
Yukon2s. However, Anton reported other servers using this patch with no leak. 

Ariel - are you using sk98lin? The only other modules I'm using are the ALSA 
modules for snd-hda-intel as of ALSA version 1.0.11-rc2.

Cheers,
Chase
