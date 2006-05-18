From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 10/22] libata: use preallocated buffers
Date: Thu, 18 May 2006 10:52:16 +0800
Message-ID: <446BE160.408@tw.ibm.com>
References: <11473487902895-git-send-email-htejun@gmail.com> <446AB5EB.5050603@tw.ibm.com> <446B1B5B.2030006@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:49377 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750812AbWERCwZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 22:52:25 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4I2qNBo023916
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 22:52:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4I2qMRI273706
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 20:52:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4I2qL9s016942
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 20:52:22 -0600
In-Reply-To: <446B1B5B.2030006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> --- upstream/include/linux/libata.h    2006-05-16 11:08:54.000000000
>> +0800
>> +++ upstream1/include/linux/libata.h    2006-05-17 13:25:24.000000000
>> +0800
>> @@ -330,12 +330,12 @@ struct ata_host_set {
>>      unsigned long        irq;
>>      void __iomem        *mmio_base;
>>      unsigned int        n_ports;
>> -    void            *private_data;
>>      const struct ata_port_operations *ops;
>>      unsigned long        flags;
>>      int            simplex_claimed;    /* Keep seperate in case we
>>                                 ever need to do this locked */
>>      struct ata_port *    ports[0];
>> +    void            *private_data;
>>  };
> 
> 
> The zero length array needs to remain the last element in the struct...
> 

Ah, I see. Sorry for the noise.

--
albert

