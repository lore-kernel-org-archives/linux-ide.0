From: Tejun Heo <htejun@gmail.com>
Subject: Re: =?ISO-8859-1?Q?R=E9f=2E_=3A_=5BPATCH_01/12=5D_libata?=
 =?ISO-8859-1?Q?=3A_add_msec=5Fto=5Fjiffies=28=29?=
Date: Mon, 17 Jul 2006 08:47:16 -0400
Message-ID: <44BB86D4.6090705@gmail.com>
References: <OF816710D5.C86216D1-ONC12571AE.00456F29-C12571AE.00458245@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:16141 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWGQMrg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 08:47:36 -0400
Received: by wx-out-0102.google.com with SMTP id i28so591101wxd
        for <linux-ide@vger.kernel.org>; Mon, 17 Jul 2006 05:47:35 -0700 (PDT)
In-Reply-To: <OF816710D5.C86216D1-ONC12571AE.00456F29-C12571AE.00458245@sagem.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@sagem.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org, lkml@rtr.ca

Matthieu CASTET wrote:
>> Add msec_to_jiffies() to drivers/scsi/libata.h and use it in
>> ata_wait_register().
> 
> Why aren't you using the one from jiffies.h ?

Because I didn't know it was there.  Thanks for pointing out.

-- 
tejun
