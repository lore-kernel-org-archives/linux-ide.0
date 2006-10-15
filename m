From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] prep for PMP support, take 3
Date: Mon, 16 Oct 2006 08:41:07 +0900
Message-ID: <4532C713.80005@gmail.com>
References: <11609542672061-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:42871 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932219AbWJOXlR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:41:17 -0400
Received: by nf-out-0910.google.com with SMTP id c2so635599nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:41:16 -0700 (PDT)
In-Reply-To: <11609542672061-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of libata-pmp-prep patchset.  This patchset
> contains 5 patches and implements various stuff needed for PMP.
> 
> Changes from the last take[L] are.
> 
> * rebased
> * sata_link_hardreset() separation is done earlier by vt8251-ahci
>   patchset and thus dropped from this patchset.

* sdev->max_device_blocked and shost->max_host_block are adjusted to 1 
to make retrials of deferred commands fair.  This fixes starvation which 
occurs to all other devices when ATAPI device is active on a PMP 
connected to sil24.

-- 
tejun
