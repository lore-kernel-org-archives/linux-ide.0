Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031DC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 23:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiFNXop (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbiFNXnq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 19:43:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062FF4C7B7
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655250224; x=1686786224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BGwa4gt3lsrX6CmPrlwJtniUfIkDciPU/F/Ed6lDhtM=;
  b=cnhDkbcOpVjp2bbPvW3LmCyCtnuZr9x8TKBg3VLD4iiIPE8AvND009XE
   MNoBzhkM0FIJk2CZrJRcDRFQUPeDvBkyhCXGVcxaaL08zNwOO7/pjls3N
   GXdR7hweAq0cxxrbGcweOZqqMOYgNMcUO9fPAoK6LmiwF9LJPCY01lsXt
   aJNd2quaHxJ95mJvAOMH3GLHhQrQirvGYBSkHOv3UU5G7p+7qf+lhtAl6
   3df25AhNCLJC/g4/274FeD/RIfSifurp4/c3WybJ26+RbRo4RF3Hc0ZGH
   zd2mhgsKlw8trQESv53nqEUMPMt2e/j4QuLSkPb43NSl7+LOf0mf2MWtJ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="203166659"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:43:43 +0800
IronPort-SDR: flT6wqNJ2XPTs4at9FlB1iLtAdMm21zj/JTsiMiDNe3V3qWX0rDZDmXnQ2DJHsiQPptV6iht82
 3nVqbNX1OLwMKggz1SlE+YttjX1U3gjKMQjfvINTS/KLovHGphu0GoG3vRn6mVRu/RHIxYBrBk
 J1cczdbQ6mdfrvoxbLUy6wgsavrsdLUv6MJLB0TNSAUwzcgu03gNv/EBF8sy5JNTs/mTKrtoMt
 GqPhbWt/xFQp0oN5pJ2gdDeg2GjMI06WCfbrSFFrjCLguj9LWD52riW2T5RDlyAV2nwI6lmzuQ
 9uvr18Hze6BUxitC2yA1C4hA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:02:18 -0700
IronPort-SDR: qHEuh5+mjDFt3x6YCQttiahdJUmBes3EM1lnAiT3hpakn7fjCbwT6tlccfae/LxWiVen5MTD/1
 iKNeqp2ppu8fUsnupAF/XvdqEfqGIKjkCh6B6jGFRJPb9PJKFrhcPQiKAhBF/6D6UyrVNKu+Yp
 Y0sCu+R1TwNc00PfXJbSiyk59YjfZ1eZ7269fRbdjA3zNa189gFiNQmJAZaStWoV8oqxV9BPEx
 HSOOQtwzrKsozXUjbRkgFJXhpj16qPOvFpJBF5KfR5keNieM96dQCQRLtLtvDs/lyl4rtomcFi
 kHE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:43:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4l35nJ2z1SVp7
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 16:43:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655250222; x=1657842223; bh=BGwa4gt3lsrX6CmPrlwJtniUfIkDciPU/F/
        Ed6lDhtM=; b=MtouRr3DMFUaFJcqCV8jN7LlfQ+JC84NDSdgFIHrXAzkE55Nh2W
        ll+TO1EWh8XIL0Wf1Rgu0jfFzYHKjT52jwAfI3Fs/XhR3hMc1nZTBfsHy7Txd2/3
        gSDfL8755y3bNABgx7Sc5fE2PlCg5lY/4VSU7av69jHhPQUEw8fWRJ8yq+DP8DuP
        t1jvo5sO6umH2pUaU640Kl3g0kzlp3wWr239sX+2GF/WpaOkFuaaHWh+L6UYxlQX
        2Ga9vtVnFyUBvLp3V/LiPChq+PX2lXZpUHs3M+NZTjE0l0osLmzx94PD6PyxXvmF
        MEkGvfOLXdJoAK4zGXQmxKsM8afLWNIz5cA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VhCXrSaNoLGa for <linux-ide@vger.kernel.org>;
        Tue, 14 Jun 2022 16:43:42 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4l057nKz1Rvlc;
        Tue, 14 Jun 2022 16:43:40 -0700 (PDT)
Message-ID: <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:43:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/22 03:20, Bart Van Assche wrote:
> On 6/13/22 00:01, Damien Le Moal wrote:
>> On 6/9/22 19:29, John Garry wrote:
>>> +	/*
>>> +	 * This determines how many commands the HBA will set aside
>>> +	 * for internal commands. This number will be added to
>>> +	 * @can_queue to calcumate the maximum number of simultaneous
>>
>> s/calcumate/calculate
>>
>> But this is weird. For SATA, can_queue is 32. Having reserved commands,
>> that number needs to stay the same. We cannot have more than 32 tags.
>> I think keeping can_queue as the max queue depth with at most
>> nr_reserved_cmds tags reserved is better.
>>
>>> +	 * commands sent to the host.
>>> +	 */
>>> +	int nr_reserved_cmds;
> 
> +1 for Damien's request. I also prefer to keep can_queue as the maximum
> queue depth, whether or not nr_reserved_cmds has been set.

For non SATA drives, I still think that is a good idea. However, for SATA,
we always have the internal tag command that is special. With John's
change, it would have to be reserved but that means we are down to 31 max
QD, so going backward several years... That internal tag for ATA does not
need to be reserved since this command is always used when the drive is
idle and no other NCQ commands are on-going.

So the solution to all this is a likely a little more complicated if we
want to keep ATA max QD to 32.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
