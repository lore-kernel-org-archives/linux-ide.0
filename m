From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ata_piix: ICH7 does not support correct MWDMA timings
Date: Tue, 28 Apr 2009 20:31:50 +0200
Message-ID: <200904282031.50656.bzolnier@gmail.com>
References: <20090424134828.19575.8544.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:64858 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbZD1S1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2009 14:27:20 -0400
Received: by bwz7 with SMTP id 7so718466bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2009 11:27:19 -0700 (PDT)
In-Reply-To: <20090424134828.19575.8544.stgit@t61.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Friday 24 April 2009 15:48:53 Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> See Errata documentation. The recommended workaround is to use PIO4 instead
> which will we automatically do by flagging this mode not available.
> 
> (Bart: I believe you'll need this for the old IDE drivers)

Seems so.

I guess that Intel would like to provide fix for old Intel IDE driver itself?
