Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17098C63797
	for <linux-ide@archiver.kernel.org>; Tue, 17 Jan 2023 07:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjAQHKY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Jan 2023 02:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjAQHKX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2023 02:10:23 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA151CAEE
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2023 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673939421; x=1705475421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2V3NWgG/L/DSDCbEmm1VVQTHZwJxPmbKdUQ/aAJDqU=;
  b=gL+D+7owcAfR/DiDVmX5HHbwPhDDgTeR5OsyKdhcojhc99/CDhbVKgmG
   1Mp/IerbO3tNDGIu22gV1dKdp0OTsg+0RSnG+BunhHU1Bvy3chul/s2xI
   JZvw+EMUXno7vCW+YhRgHuWJ0dTrgagAuGHs0sOKQld+HWrXbCa0AxwKO
   SJgsmdV4bO4O7aQ3mk8FovKF+A0OlqA4n/WCc0dYpJwPnKUA6Xu4PTtza
   bsSSk+9g4qhT4mSyHGBwBTPDcY0vzbF0xHuqdAZWjhQGe6I72jcE3F0os
   k+7X4PnAgNt5AnlD/z/WUzIpABqxult36ShHKVElvOFAxE5bsNgqKdqUJ
   g==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="221066033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 15:10:18 +0800
IronPort-SDR: 4Zo0e4H0W6r1ZK7GF0Y88CDx+I80b/3SeW/jqlGYjMoG7e1NF9H24GDBlIHh3gqRPhnMXOH2Df
 Hm+yfjXPjNprTZOVEj9f1GycWw5ORLtoa3nT/mBU3Zy532SGbjgcDOArM4+ZP4vu5dbipFI2Z8
 SlfowIHSe24rypAEG0SicYbwGFqCnZ9xQLKEOLiEHni6yIz+RJSGTe0KH/OZKWsWOOpJmgFNvu
 jwv9lo//xL/iKnk4dyzIkwk/aTJu1nzC35Nrc38npfdDxWwO2+EUZURbqm2I5/y5zalTj4Y4Tj
 6uA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 22:28:00 -0800
IronPort-SDR: ayZNqiE8xGBkZ62Gni3rtqgidwwFJdWEdqjAbs4P+XbbELTGFsATwecTEeaRRcySY+bRPK2xFn
 bkDswcjBNhVYVG4CMvat5Gd33vo3C9wLAd3AZ/Z46bWFH2Qslv9Yu+dXWHB1Yihw4soRscKmZI
 v1JeUaUneoRmomDXXVe5PpschiOuccIXb7bKBsr+UKEzqYItM+Qq5UARDrGi9oMfxu8cOL6bkc
 zJcNzy52FUUYB8FUkTyUpBvC3b1BqMWTCrJGeYeSZSkDSSpn3cCD6uaRB5ZfQAE9ol8vcwkv++
 M4A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:10:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx0Qf1CzWz1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2023 23:10:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673939417; x=1676531418; bh=q2V3NWgG/L/DSDCbEmm1VVQTHZwJxPmbKdU
        Q/aAJDqU=; b=W4w/NhrRr35fGiw++8g0VuA85AvFEl8y56V1TXQuFhJKoOgFt+v
        uAG7jb0/jULdOZE8fm+vCJjlIcccVxfvuChA1kYk6H3iDoZu9SeMaiwkS3Uw0xZ+
        wt+GDLCWWbvLuSxLDE2zP96MMAQCl2X7znS2/FdyQqMYwyO5/yQOh1DvQ22UyAcY
        I75VPwFvXx0jN4aDwxS5DRzifkH1KAW3STgMQ9mzMay1+5J0ByoSFDuM6VyI9QSL
        XAg11N0m2G4GjGobKICLRG/ggudsCMRP8rgF5b1kbZ7Mw5UvrKTlWRsHAybTgws+
        +JNBR8wfuWBf2Nx3mPaWANWusFDHo0gwbsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lw2klLbslCfq for <linux-ide@vger.kernel.org>;
        Mon, 16 Jan 2023 23:10:17 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx0Qc58DWz1RvLy;
        Mon, 16 Jan 2023 23:10:16 -0800 (PST)
Message-ID: <04ab7f5a-9ba2-09f3-7aff-61cde2696d25@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 16:10:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/18] ata: libata: allow ata_scsi_set_sense() to not
 set CHECK_CONDITION
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-2-niklas.cassel@wdc.com>
 <Y8Y6/xa3thf4/UNy@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8Y6/xa3thf4/UNy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/17/23 15:06, Christoph Hellwig wrote:
>>  void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
>> -			u8 sk, u8 asc, u8 ascq)
>> +			bool check_condition, u8 sk, u8 asc, u8 ascq)
>>  {
>>  	bool d_sense = (dev->flags & ATA_DFLAG_D_SENSE);
>>  
>>  	if (!cmd)
>>  		return;
>>  
>> -	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
>> +	scsi_build_sense_buffer(d_sense, cmd->sense_buffer, sk, asc, ascq);
>> +	if (check_condition)
>> +		set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
>>  }
> 
> Adding a bool parameter do do something conditional at the end
> of a function is always a bad idea.  Just split out a
> __ata_scsi_set_sense helper that doesn't set the flag.

What about passing the SAM_STAT_XXX status to set as an argument ?
Most current call site will be modified to pass SAM_STAT_CHECK_CONDITION,
and we could add a wrapper ata_scsi_set_check_condition_sense() to
simplify this most common case.

-- 
Damien Le Moal
Western Digital Research

