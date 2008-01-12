From: Alexander <aledin@mail.ru>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash on accessing
 DVD-RAM
Date: Sat, 12 Jan 2008 10:25:38 +0200
Message-ID: <47887982.6050805@mail.ru>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no> <478702C7.80401@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762083AbYALIZz@vger.kernel.org>
In-Reply-To: <478702C7.80401@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Robert Hancock wrote:
> There's this patch which was intended to fix it:
> 
> http://lkml.org/lkml/2007/11/22/148

I applied this patch to 2.6.24-rc7. Now at boot time my DVD-RW is
normaly detected as:

sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray

But I cannot mount it. All my attempts failed with

ISOFS: Unable to identify CD-ROM format.

With mem<=4098M or sata_nv.adma=0 it still mounts and works ok.

