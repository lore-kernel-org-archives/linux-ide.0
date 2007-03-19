From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 19 Mar 2007 09:22:20 +0100
Message-ID: <45FE483C.9050207@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FD5927.7080104@gmail.com> <200703181654.00829.bzolnier@gmail.com> <45FE0417.8040200@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:17551 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbXCSIXj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 04:23:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so986056nfa
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 01:23:38 -0700 (PDT)
In-Reply-To: <45FE0417.8040200@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

What about ata_piix, have I enable this?


> 
> 2. Reconfigure the kernel.
>    Remove the IDE pdc202xx_new and add the libata pata_pdc2027x driver for debugging.
> 
