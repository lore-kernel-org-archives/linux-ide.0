Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9578BC4332F
	for <linux-ide@archiver.kernel.org>; Wed, 19 Oct 2022 05:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJSFEt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Oct 2022 01:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSFEo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2022 01:04:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE41A82E
        for <linux-ide@vger.kernel.org>; Tue, 18 Oct 2022 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666155882; x=1697691882;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=aezxt+wiCO4OS7XmdAoNBnf6wL05CDtlT5+KDSSpB4Y=;
  b=dRjTShtLRIQRe4zb/8xyOOxQkyWcGuCzcLsHGI41fx06iX5Xfxt7tD//
   S9//b8e7aGqz0XMuMHiqLTxwl6N/IN+h+hu+0NJZE3/qb3+DHp3GshZNW
   UEAcssEY7JPjnMOqw04n2SEQtYYLVuOJqnBnbyN5yoGlV5sbPAANkrfhF
   imMAvJcYhsuW5mEjB5TGbsx911XoCszy2tAYMMufzoRG9ZCNxKZoVnFCO
   HpSsRaH2aMqsb0B6oh+IoBBBfe7Iyf5ukxhdDQBZJbzDZh/xWMXQSAdC+
   R5TJC7xZ2iuFS9JCAENTsJctwOEeugJKnYjoednkmSLlqv4b5wqeQweIo
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661788800"; 
   d="scan'208";a="326298614"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 13:04:36 +0800
IronPort-SDR: 8jfGQXBb8TiqS/mdba7LaATXWKOXVkRmVs9E2aEclHbCOf4rY5K++Zn5ofOxGqBK7n9PbaGN64
 yKgnYVgJ4GmkorCRF+YD1ZHMvq+E0bI8gwV2jsWLjjJf1VlrKI+b6cpeXsdnpY5dbR5m0ClOL9
 aJufjdyupflHj/BcN3jKqdi8WjMsLvfFYUQMrlWtZCjpKjMXGPWMwakFvewUsVAt+E1aSyko10
 /20IaLuR18rW61CIbGoNV3Vau6pblTAGe5vHenxgeBqQOsL3bdrot+HMELArI3ETbW00/5VpBo
 4PJX113ZqHJU8aZXzDi3OUZV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 21:24:07 -0700
IronPort-SDR: zS+eV0qJsAhzRGAXZ/fm66knzCv6b6Z/3aDTncYWSeKEFhdrdwYDr/OruOgm1ZexOZogPP4XCA
 mF7s8i/i7M+qw4x9LxuJpVvjNhkv7Hh6/fxSeLXrFhnbxaM3t88hEba2dmK0ZYOFqnUtQtsDx3
 5yJzCXMAIvdZJOQmIBxnImNLMAv0INpri5VjTN1PPN/Q8ZpjnA8Mn3j7xqbP43MlJa+uoInO6Y
 Jl7pcjoHQlCF4ZKAOfnFrGS0hvtQHaYKhAka9o+zXRcDQvVAV/QcuAPrOk/IDFvGP3SszfPXay
 4xc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 22:04:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Msdv76YHgz1RwtC
        for <linux-ide@vger.kernel.org>; Tue, 18 Oct 2022 22:04:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666155875; x=1668747876; bh=aezxt+wiCO4OS7XmdAoNBnf6wL05CDtlT5+
        KDSSpB4Y=; b=X4izOHvjqNEiah/pTg5N8oJN5xBqFTveHWiP2YjrOM7mY7dHjRP
        yft6yoz3L8PDshlJ9n9K7fjqAV/SzJMHV9YjbyJHOtkOAUT/oUphjH0yn9k84W9h
        DRy2wQ5UWcClmpddGu4FFh30iI3kE8lc8cbleRVAUphl+vvKU7cnc+jG1OAVrih1
        LGBtQgHI0VK5vxJZK9HQFOQzP+yc3GwI01rOzl8vlxTvdgb3ij2YR7r+VsSrf9Xt
        baH9CKNV1ew9grhvyaxdT1Yj0/PYHSyJ6gYh3xzibwHpTCpqw9Mzx1z7hyFLWC7k
        s9H84LxUB78cnMrj6V4xjE1Gdnn/pvxdAXQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wiIG1F-PwNZS for <linux-ide@vger.kernel.org>;
        Tue, 18 Oct 2022 22:04:35 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Msdv63JZ5z1RvLy;
        Tue, 18 Oct 2022 22:04:34 -0700 (PDT)
Message-ID: <a5026aa0-2674-9b2d-1a0f-ed3847fa69cc@opensource.wdc.com>
Date:   Wed, 19 Oct 2022 14:04:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: libata and software reset
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     John Garry <john.garry@huawei.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
References: <046e86d2-17e1-e85d-08a1-744ef975171c@huawei.com>
 <7e8ef4b4-928f-895f-05ef-df111a052e8e@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7e8ef4b4-928f-895f-05ef-df111a052e8e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/19/22 14:03, Damien Le Moal wrote:
> On 10/18/22 22:24, John Garry wrote:
>> Hi guys,
>>
>> In the hisi_sas driver there are times in which we need to issue an ATA
>> software reset. For this we use hisi_sas_softreset_ata_disk() ->
>> sas_execute_ata_cmd() -> sas_execute_tmf(), which uses libsas "slow
>> task" mechanism to issue the command.
> 
> Something is wrong here... The reset command sent by that function is
> for ATAPI (DEVICE RESET command). There is no device reset command for
> SATA disks following the ACS standard.
> 
> So hisi_sas_softreset_ata_disk() seems totally bogus to me, unless you
> have a CD/DVD drive connected to the HBA :)
> 
> This is why the softreset function is a port operation defined by LLDs.
> How you reset the device depends on the adapter. E.g., for AHCI, you
> need to send a host2device FIS with the software reset bit set.

See: ahci_do_softreset() for AHCI.

> 
>>
>> I would like if libata provided such a function to issue a software
>> reset, such that we can send the command as an ATA queued command.
>>
>> The problem is that often when we would want to issue this software
>> reset the associated ata port is frozen, like in ATA EH, and so we
>> cannot issue ATA queued commands - internal or normal - at that time.
>>
>> Is there any way to solve this? Or I am just misunderstanding how and
>> when ATA queued commands can and should be used?
>>
>> I assume that ata_port_operations.softreset callback requires a method
>> to be able to issue the softreset directly from the driver, like
>> ahci_softreset() -> ahci_do_softreset() -> ahci_exec_polled_cmd().
>>
>> Thanks,
>> John
> 

-- 
Damien Le Moal
Western Digital Research

