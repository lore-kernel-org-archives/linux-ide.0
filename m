From: Ian Hastie <ianh@iahastie.clara.net>
Subject: Re:
Date: Wed, 17 Mar 2004 20:43:50 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403172043.52582.ianh@iahastie.local.net>
References: <200403171808.i2HI8EFs022916@lamont.ldeo.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:45774 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262058AbUCQUny (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Mar 2004 15:43:54 -0500
In-Reply-To: <200403171808.i2HI8EFs022916@lamont.ldeo.columbia.edu>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: yue-feng sun <sunyf@ldeo.columbia.edu>
Cc: linux-ide@vger.kernel.org

On Wednesday 17 Mar 2004 18:08, yue-feng sun wrote:
> The dmesg shows:
> -------------------------------------------------------------
> Kernel command line: ro root=LABEL=/ hdc=ide-scsi
> ide_setup: hdc=ide-scsi
>
> hda: HTS726060M9AT00, ATA DISK drive
> blk: queue c03cbfa0, I/O limit 4095Mb (mask 0xffffffff)
> hdc: FUJITSU MHT2040AH, ATA DISK drive
> blk: queue c03cc404, I/O limit 4095Mb (mask 0xffffffff)

hdc is an ATA hard disc so should not be being set up for ide-scsi.  You need 
to remove the 'hdc=ide-scsi' from your bootloader configuration.

This is a configuration error not a problem with IDE.

-- 
Ian.
