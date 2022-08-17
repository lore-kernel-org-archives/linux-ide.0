Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE12C25B08
	for <linux-ide@archiver.kernel.org>; Wed, 17 Aug 2022 16:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiHQQnr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiHQQnn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2022 12:43:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D32870E
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660754619; x=1692290619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9P110BpfEfdFuedgxiCRNcVFUjzjcYAjMZKsJ1joFA=;
  b=hBlmYbmUHkNIssnnN83FTcXEhds8MiU+Fa9UaAiUdoeJfKbkOOy6mkgi
   +5No+hZPUaJNBrb1FX+MKniDsRWeUyStwoqNly52dqNMNAgzMCyulaYUn
   AuSqYN0W1p5ZvGzHFl7/2fkLG5dQ32Z1RYmneEaDAXo24MJ+5Fvkh1sl3
   wJP8yVqrvO03Wunoq/w5YdQZPDrzidqXM/tCxJgToUB4YKCtOzkA8HL3W
   UtuS2ZsfhlZqY2kl4siBlpf28vmYLBuN/fCpO5wPKeLHjN2cPQFDXdxZd
   /R3vNTzYVE6Zg0jqgbXafSV48EwuXAP3AXQDiLz5UsUjD1XI5w9FseRJV
   g==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="207428717"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 00:43:37 +0800
IronPort-SDR: AVkmO9t0e61HrcdGeuo+tRPSUxkPuI/Q1kLDnc4R4pmwmVuPYEo+jtiOfWTsVPnwkiWcCKkfer
 8D6zbkrORwktdTUf1uvLnH9gOFJ/OOuihl1WYB1MLYNNIv5KIvJa4no/bpyKA1FWyvEQPpjmvI
 +cbPsZ1HN1NIlAhL/a7iSK7UZErlqYI3sJVkN4RbSXeV0ZE/D4nydckck/oAwncojfk8R7evxM
 8oeFAUzA3+jJB8+yN7/sqk72h8dNKN8MsCt/y1LOnR+36re4IJxSJkKdo4S052cbFNS6u8OZn3
 3oW6tLMKxgCvrMuNwjjHVirt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:04:23 -0700
IronPort-SDR: II4sbPrZRCkEee/CfMMiQ8xPuHhtBKUylGDoZSryM4qTUkt6zzxnET8keXHlV+/jY122EHBkDw
 kNL/5WIkZTGc1Aj4Iu6UTJ+za907xGj9qzALsmgxmIqlMjFdf4i26/T2CCvhMKQAQsIMeuQzZZ
 nqCs1WJptR+P1v32V2s4j3v7dEAD8oAPVetipuxZkbdqidPCMOo9Ixlk8OcuM2x4/YzzUrg/y3
 LER/QnpXNm+R/f6Xw+DQCLrvEbg5jNp2Ljz9pC+Zn8KwdWSuSDQFRwdYT0COEknbs1EWEnqKSM
 UWU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:43:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7DNn04qtz1Rw4L
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2022 09:43:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660754616; x=1663346617; bh=s9P110BpfEfdFuedgxiCRNcVFUjzjcYAjMZ
        KsJ1joFA=; b=EsvWuLcqVBiITHzzBr9iMM5nfFLVDDukMJ3TDZgX7jK3jHFfSYk
        9MLqnhaBZR3ok6L96Ac/MuOxj+kx50NQzNbPJGLTa6AmzCm7YuF2SO6zTrt0ct6D
        Gvy/E+RmV2JbZamQ1yCgZGTMltvirzqO2SM0YLDRpvhc0L1Po6v9QT0Elr5p/qOh
        Rp27Y0oiZej/TmYLAoP7VGKjMLS1TAKrm2l3kdCVQQaL0StLChofmWSkIzBJkpmZ
        MC7Gj3EbhnSMEndPYqkA1PN516tBazcx/8JFKBQKKVCRgqxnc8/Z5z8wbVmsyKst
        XkLuK3ZNF/7WDmFaw5mithGpa94bv1jwhYw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z8WDe2FFvtU4 for <linux-ide@vger.kernel.org>;
        Wed, 17 Aug 2022 09:43:36 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7DNm5Bmdz1RtVk;
        Wed, 17 Aug 2022 09:43:36 -0700 (PDT)
Message-ID: <51e4f1e8-7fcf-7599-2e53-f3dd364d674c@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 09:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] ata: libata-core: improve parameter names for
 ata_dev_set_feature()
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220816115329.1252278-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220816115329.1252278-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/16 4:53, Niklas Cassel wrote:
> ata_dev_set_feature() is currently used for enabling/disabling any ATA
> feature, e.g. SETFEATURES_SPINUP and SETFEATURE_SENSE_DATA, i.e. it is
> not only used to enable/disable SATA specific features.
> 
> For most features, the enable/disable bit is specified in the subcommand
> specific field "count".
> It is only for the specific subcommands "Enable SATA feature" (0x10) and
> "Disable SATA feature" (0x90) where the field "count" is used to specify
> a feature instead of enable/disable. The parameter names for this
> function are thus quite misleading.
> 
> Rename the parameter names to be more generic and in line with ACS-5,
> and remove the references to "SATA FEATURES" in the kernel-doc.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.1. Thanks !

-- 
Damien Le Moal
Western Digital Research
