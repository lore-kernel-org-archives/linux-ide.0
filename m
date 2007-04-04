From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] sl82c105: add speedproc() method and MWDMA0/1 support
Date: Wed, 4 Apr 2007 21:38:24 +0200
Message-ID: <200704042138.25049.bzolnier@gmail.com>
References: <200702140043.25244.sshtylyov@ru.mvista.com> <200702231913.55522.sshtylyov@ru.mvista.com> <200703290024.32035.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:15869 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993041AbXDDTgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:36:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so782485uga
        for <linux-ide@vger.kernel.org>; Wed, 04 Apr 2007 12:36:41 -0700 (PDT)
In-Reply-To: <200703290024.32035.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Add the speedproc() method for setting transfer modes, modify config_for_dma()
> to call it and use ide_max_dma_mode() to select the best DMA mode.
> Add support for the multiword DMA modes 0 and 1, using the upper half of the
> 'drive_data' field to store the DMA timings to program into the drive control
> register when DMA is turned on for real.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
