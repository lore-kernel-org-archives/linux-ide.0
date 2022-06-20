Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CBFC43334
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jun 2022 11:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiFTLY5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiFTLYz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2022 07:24:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9315FE1
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2022 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655724292; x=1687260292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oxhVRJ6tOkVNNCJSnJSYC9k+6zLYgkj6GgwGyEKrNWc=;
  b=dNKtaVVIVJbLE2ZRRSt7RsjWUCvzLaR5TV3Ps2UW+4PSy41m9XJ/KBMz
   Jj0izipOAiPrVCb3XwzwjtGZ27IlaVuP54zLzUwLyjkYgcqKzn6B/ZwlO
   vIVs39lD3ztg89doz7syJdKabfmOpGuBzMbVjdBHTl0rf1WoFQuP9aquz
   tndT122Rwq7gqlxeIBnN/hhuSoKpTzhlZqpiI+mdUHFYCsh2dkylKI2R2
   phSuxXedcDL1CO8eJR4WtDiGDNjl2jPmVYdpaZIMCw4DefljTPLtopg5A
   4npYFrxjJGI/ngMaO2W0M3helmoTDjL+GXe5b+RYvNHcIoMffrX4eFjnz
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208478719"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 19:24:51 +0800
IronPort-SDR: wQ33hhV3xX+/k3SBCpnKp5GU8NM0i+/wfEibjZjK06WXdmRbcteTBbLshPGbIXX7lYpbscnCWz
 NRPfspSiVGqcbUkW8SAnO9ywGtdn/A0G6MBbhraUC9EYUl3mQ1hluoeSgOENwhCL1K2l7PP9iW
 kcs6sAjMrQySab0qDmyqhVM/GP02W5lYO8KyxPt2UgLfzgt9fyOfiSYqqto9nP+W4mSR5OY0AF
 +HOkb+nEwi+eXQDmv9DkyNVpYc6yp6I3Avh6hTpNBZbIMZX0byNaW6EzGGg/k7zElci0byviTp
 KmIa7k4hW24KR6XTQ33i6G8f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 03:43:02 -0700
IronPort-SDR: GC3oxw7DlNZ/2Y6e81MhZT8F+fxYnXn4yS9DMMFu6mIRyr/lJ4C1YA0bGyI9FOBGZ5cPwe7XY8
 tMSIH1GcqnDzvAXDVSzNE3Mi3DQz4IKI5LXfASvAZPAtjN6dAyMjCliFpIoZqF5szZ40LtK8zs
 3hv2Ax2NPk6+RGJsYdvVq071fh8otZ4y9AuA7MTShJeqdYtU2ikj5lw471+2WFcYZv71OMDWs6
 dLrJx3Ik2MOsj6W59ApHN/EmO5zOgFSL07JDdQ9rJdei9VkgMOaA/FKiKGQ2azq4xSlpRhPRUU
 OYs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 04:24:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRS3m1H2Rz1SVnx
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2022 04:24:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655724291; x=1658316292; bh=oxhVRJ6tOkVNNCJSnJSYC9k+6zLYgkj6Ggw
        GyEKrNWc=; b=ts0IFfQwD5Ix0HxpEyjed/zuPEgJWH7rwbIKA9DOhvCJ+JH+g8g
        OrwqwcaIvmZkyZY6I3/jiYdxx/ExoQgCuyvCoObqNlwj79U5sZeyezUibP2KHNGJ
        ao9O5FhXUlrCa8S4n5lFBTSlN2C88uzG0Xa0VqhPVdNLHlzohIfV5LdjI4mAweju
        6VYJNIA9KHaC3zhOay0ZF1+UmE1xSIF8etAsm/E7/XtXoZaRGDQAmYXNyV0ijtWB
        G0r0NKHaBCJ87szoRqzhfuGl7rNJzj1ZfOUGvUEznCWoDLNZ8Sxc20NTC1bZiMVM
        +3rSJWEYnnvOydUJ9B808GUCfI3HdR33Q4A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3rZ3YmTH8J2H for <linux-ide@vger.kernel.org>;
        Mon, 20 Jun 2022 04:24:51 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRS3j3PyMz1Rvlc;
        Mon, 20 Jun 2022 04:24:49 -0700 (PDT)
Message-ID: <41fa0f12-cdcf-f2c4-7366-1abd04312f1f@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 20:24:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
 <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
 <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
 <c702f06e-b7da-92be-3c4f-5dd405600235@opensource.wdc.com>
 <ecfb0694-21b8-55b4-c9b8-5e738f59ce8d@huawei.com>
 <98fa010d-3555-a82b-e960-f47aeeb38151@opensource.wdc.com>
 <7b046321-fdb3-33f0-94a0-78a25cbbe02e@suse.de>
 <9de5ed1b-e874-28ac-0532-cd5420892064@opensource.wdc.com>
 <20220620090543.GA13643@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620090543.GA13643@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/20/22 18:05, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 06:02:30PM +0900, Damien Le Moal wrote:
>> So reserving a tag/req to be able to do NCQ at the cost of max qd being 31
>> works for that. We could keep max qd at 32 by creating one more "fake" tag
>> and having a request for it, that is, having the fake tag visible to the
>> block layer as a reserved tag, as John's series is doing, but for the
>> reserved tags, we actually need to use an effective tag (qc->hw_tag) when
>> issuing the commands. And for that, we can reuse the tag of one of the
>> failed commands.
> 
> Take a look at the magic flush request in blk-flush.c, which is
> preallocated but borrows a tag from the request that wants a pre- or
> post-flush.  The logic is rather ugly, but maybe it might actually
> become cleaner by generalizing it a bit.

Thanks. Will check.
I am also looking at scsi_unjam_host() and scsi_eh_get_sense(). These
reuse a scsi command to do eh operations. So I could use that too, modulo
making it work outside of eh context to keep the command flow intact.

-- 
Damien Le Moal
Western Digital Research
