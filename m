Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649ABC433EF
	for <linux-ide@archiver.kernel.org>; Sat, 15 Jan 2022 01:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiAOBjR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:39:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60032 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAOBjQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 20:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642210756; x=1673746756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Co1A4b8/YuxPGi78oK9IUFZJWO2lkJaY4HyvqxfXijc=;
  b=X/00/MxrkFe3w3lnM1DTlmiQZ6WJ4vTxQ1xP7HKD5VjajD8qqDVuCvgV
   RPJ2MZ1ZFIH4ls5XgbyrCuDAdJCBg9vtM9ieBg1tVZWPW2t5z0FM685jv
   +owyIXMlUywB2mM25MO8KlFBfqIs0km+tQYpW98h5AOUqyK3JzZkuTiIX
   +Zdsi3rz2MjbzTetrv5wB+A6i9GYd/uRvs0x0rZRemJSJnzRuWr/TlGIH
   xyJf074lZIljTYIVlv2+6SRoliexxJ19LN9TLrkxKzxdz4B8YtS8wkBgw
   6IL/5biaDhIp2Eg60gXm1Sf3QCe+nGZ3hIsk67SxJEvEENzb5S1O8/gw8
   A==;
X-IronPort-AV: E=Sophos;i="5.88,290,1635177600"; 
   d="scan'208";a="195303681"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2022 09:39:15 +0800
IronPort-SDR: KIjL3RqFJoZlj4HL5eEHkzanNND0ipKkGfcy718JvqK5TeG7ZKWSXkkB/EFEL/kuxzucdxzVLz
 jsZXACRGBxFIky1r6w0H04JMf1a5jatNUKq3L2cXcirPAjFPhpyOGzoHESEh4XaHL0XnencjyF
 BoPSy3N6tcMlsDK7MkBFqOrXIGH2TwZVROuVBsW/9qnuUAVhv88Z5CtYopHykNHpYRGyEqrpdG
 QFm6rba6jFd8SjmeBRJPgaFx4T5AiPUxE3itPDSLaOFl8VeF53YJsxjR13ZEim5A/GKf8uUacA
 jLoSkqO3oKrsGGF0onV05O7X
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 17:11:35 -0800
IronPort-SDR: DUXjOi9kOpqS1h3LQtZvIs8xajBm/4d0F9BqZOkguaKaZr4utdDGwf6vKqL/jawXTZHT3KYetC
 DlIvCz31SAILR7ZcnekRMyoEHnUegPRpW1CPlL6T+7kqvco4IP7s7suABuokoddrZW/Zf1XXF6
 8wTDodN858Ne/iJaKsy4rYVXC+wagilrEmQFnXBwJWiRuYElb2HDgQO3+TrR9EokUhaf5skA47
 ndtk+zZ4+2sYEk443ZQUnLs4hwfFRKCv6rGNB7tWie3Yqu6drhpz5ZEHq50vt7TcSSs+dHiCRE
 Pv8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 17:39:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JbLS35pZrz1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 17:39:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642210754; x=1644802755; bh=Co1A4b8/YuxPGi78oK9IUFZJWO2lkJaY4Hy
        vqxfXijc=; b=e8BPvyr8an+KADpKA1B3JowFKwNgOTZieCI8U7YaMQThYMuGTHq
        9ZEY2/vJkUU0tOPl7zZYd9hQ9XbbAlgXZj/ePBbYhvVg81b1FmjHpdB3K1MTOGiE
        lWilp8ZLLTPUtyMzCMnJZlmnfdEngj9+z7T6nx0P8Ns3/h2AGFf3MhaYAQ9NYwXp
        yn2mBuwJ2t3lX58nmVjczZttqG4H1UEsZW/0W9mCLKOnro8d7wkOmZzlzhXpUKfR
        3zZVWXJc3pkmbSZi8ZkHJot57VIbRk3Dk98fqGkB3jnmQKbg8ZSMK+Bv8rAIo7/C
        szZr5rA+tiAwC+C+Y6BDEg1sy0X1dK95dxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wdm92Yx_jZ3c for <linux-ide@vger.kernel.org>;
        Fri, 14 Jan 2022 17:39:14 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JbLS21GdKz1Rwrw;
        Fri, 14 Jan 2022 17:39:13 -0800 (PST)
Message-ID: <89c96d05-ef0c-513f-5d2b-bfdcd86c4d58@opensource.wdc.com>
Date:   Sat, 15 Jan 2022 10:39:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
 <c365e182-d531-9854-1ff7-9c97d5af9544@opensource.wdc.com>
 <20220115103713.69719bda@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220115103713.69719bda@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/15/22 08:37, Stephen Rothwell wrote:
> Hi Damien,
> 
> On Sat, 15 Jan 2022 08:27:12 +0900 Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 1/14/22 22:54, Linus Torvalds wrote:
>>> On Fri, Jan 14, 2022 at 7:59 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:  
>>>>
>>>> ATA changes for 5.17-rc1  
>>>
>>> A number of these commits are not in linux-next. Why?  
>>
>> That is strange. I have kept my for-next branch in sync with for-5.17
>> all the time and got several built-bot warnings that I addressed.
>>
>>> It looks like you have rebased things very recently (and looks like
>>> you did it a week ago too). Or maybe some patch-queue system, or
>>> whatever. Why? If it hasn't been in linux-next, you should explain
>>> what's up.  
>>
>> The last intentional rebase on 5.16-rc8 of the for-5.17 branch was to
>> check that there were no conflicts nor any problems with the fixes in
>> 5.16. I did that because Hannes series touched a lot of drivers (if not
>> most of them).
> 
> That check van be done by doing a test merge and if there is nothing
> major, then don't bother doing the rebase.

Understood. I will do that in the future, and not push the rebase.

> 
>> I am not sure why the patches do not show up in linux-next. As mentioned
>> above, since I got several build-bot warnings, I am confident that this
>> went through build tests and passes. Or am I missing something in the
>> workflow ?
>>
>> Stephen,
>>
>> I am almost certain that you are pulling patches from libata for-next
>> branch since I got build bot reports and you also pinged me directly
>> about these. Is there something I am missing about linux-next ? Is there
>> some other request I need to send to someone to get patches pulled there
>> too ? I was under the assumption that your pulls end up creating
>> linux-next...
> 
> I do fetch your for-next branch every day, but here is the "git
> range-diff" between your branch in yesterday's linux-next and the
> branch I fetched today:
> 
> $ git range-diff e928da321f0bd51f9cf211eab0a7b2fc089685a7...libata/for-next 
>  1:  bd7300988b26 <  -:  ------------ ata: ahci_st: add compile test support
>  2:  e3e44274998d =  1:  28a53d3160ac ata: ahci_mtk: add compile test support
>  3:  eec6634ee717 =  2:  368c7edc15e5 ata: ahci_mvebu: add compile test support
>  4:  003785331487 =  3:  c05b911afffa ata: ahci_sunxi: add compile test support
>  5:  a4dd1e0f6542 =  4:  3d98cbf7096e ata: ahci_tegra: add compile test support
>  6:  9ec8eadac3a4 =  5:  b7c9b00fb050 ata: ahci_xgene: add compile test support
>  7:  9fc38794e9b2 =  6:  a33a348d0aca ata: ahci_seattle: add compile test support
>  8:  e9123b1cef47 =  7:  a3d11c275b64 ata: pata_bk3710: add compile test support
>  9:  4c8bbbba007c =  8:  e5b48ee30aec ata: sata_fsl: fix scsi host initialization
> 10:  04ed3c17408e =  9:  f8bc938ee6c6 ata: sata_fsl: fix cmdhdr_tbl_entry and prde struct definitions
> 11:  d64f9dbf0ae5 = 10:  2bce69072a0d ata: ahci_xgene: use correct type for port mmio address
> 12:  75d7ef1d0409 = 11:  0561e514c944 ata: fix read_id() ata port operation interface
> 13:  953e5fc04f30 = 12:  9c2fd3fb43bd ata: pata_octeon_cf: remove redundant val variable
> 14:  b76fc153e3d4 = 13:  dc5d7b3cfd78 ata: pata_cs5535: add compile test support
> 15:  148f7ed51e8f = 14:  2aa566716f43 ata: pata_ftide010: add compile test support
> 16:  6aef8c23f268 = 15:  7dc3c053bddf ata: pata_imx: add compile test support
> 17:  017253b5a7fa = 16:  7767c73a3565 ata: pata_pxa: add compile test support
> 18:  f4c8787686a4 = 17:  b6a64a860e13 ata: pata_samsung_cf: add compile test support
> 19:  e790a4f79933 = 18:  db6a3f47cecc ata: pata_of_platform: Use platform_get_irq_optional() to get the interrupt
> 20:  cadac042d432 = 19:  84eac327af54 ata: libata-scsi: simplify __ata_scsi_queuecmd()
> 21:  a49c0c3fc253 = 20:  b9ba367c513d ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
> 22:  6977409c421b = 21:  a17ab7aba5df ata: ahci: Add support for AMD A85 FCH (Hudson D4)
> 23:  e928da321f0b = 22:  237fe8885a3f ata: pata_ali: remove redundant return statement
> 
> So, you removed a commit and the rest is the same.

Yes, I did remove the patch that added compile test for the ahci_st
driver as it was generating a warning with an hexagon randconfig (see
https://lore.kernel.org/lkml/202201122335.B7ADTynl-lkp@intel.com/). I
removed the patch as I did not see a clean way to avoid the warning.

Linus,

With the difference noted by Stephen above, I can see all patches of the
PR I sent in linux-next. Does that address your concerns ? Please let me
know if there is anything I need to do to fix the PR. Thanks !



-- 
Damien Le Moal
Western Digital Research
