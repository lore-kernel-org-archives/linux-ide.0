Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F7C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 13 Apr 2022 03:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiDMDtU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Apr 2022 23:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDMDtT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2022 23:49:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CAE1B798
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649821616; x=1681357616;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=U4pyiGbh5ZGbN9/axQmKhYkqHfExVYqhDSuYXWCl9Fo=;
  b=I+H0pLZSFSyBz2RUNN12je+UQH0Jxo2iPB0yC63e7qzwNGbuIYxKZalE
   iREHWdBOB33iSfA7dyzgJkmGPjvVu6UR0TQZupEa7r/K5v0FCJdw5EiPM
   WPKAfWGh6HUbWstG1V31Vuzt4dvKjNbHeeXoMqVQ5tIZdh4Nz1lHGnT0Q
   n0papwMtwBBI13s43P5msyNt7baz6UyYYjv5Fg3erjh/X/yCgX8im8OFH
   muAZwaLZfmnxZWwDcQVVU+HneLNTfibq3nD2JeXms3qVkaRnmE6NRn/BK
   lNuWS7nsFpjqkmizEyqFy8oEk9V2d8pAWaYhMVeDWhl9dnL9eFzVwmv1K
   A==;
X-IronPort-AV: E=Sophos;i="5.90,255,1643644800"; 
   d="scan'208";a="196654327"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 11:46:56 +0800
IronPort-SDR: qZWMpBZ5bsPrhrg9nOP4q9CsqueTRkkBAU/FuBfH0sa4M9HwPZ+Z505fwFqhBiaSCqw7Dhk4Kp
 i+2dU2DFJ85xFlGcxHl1/r9EWlAXmGWs3RlHR/+3idY9CDOEXGV9BXlGRm8M3ztXBOfEhTyOBr
 tRbZZZL4ofjiOfcEo4Dzfdbi3NzOYP5FAbJeP7IaWydah/3e7raHTvM67rXsGUPtm8v3eSGKT7
 aTfOAks+f7eZjBGLToLaNjdJHasq8fjwu/prAiDlVC9Vma0QEs+bebR4k/yGTZJmPO0hCAAzqD
 IgzIvX2knHabmPg15sRWcwFb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:18:11 -0700
IronPort-SDR: SFWvAUDUE0seWfTej6xXT8RHbhNnAZvBb0SPLGS1+tQK/KkF4dZQpdENUyQsZjme3W/NTqd3E2
 ybq79pxDmi1gZ6y59278RI/VtaOdfe3OeDoqmb2DvFNWnyooq7xDMItRtA7+q6W8aUqnVx0vme
 3Mp5Wsq6jBNc1nqUgUKJvOuBpxXI5fk2Jrpl38GDPPUQt5BxzikMGJyCNJ4s0EbOB02Ud4/kYb
 B0lKObthzPKM0QRVW1AO52WQGwDe/+C1jruaiG+rRASDt6gruKT5EkKNX5zG8UPE3B45Z6YiHw
 ypk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:46:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdT6l52KDz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:46:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649821615; x=1652413616; bh=U4pyiGbh5ZGbN9/axQmKhYkqHfExVYqhDSu
        YXWCl9Fo=; b=JRogh+SAjuSUNK7qf8hil4MCgulxLBWvA9+ckxtakhiHkBegOCz
        0O1cuJnASrksH7FRIO+CAfvq6Kk/uk881EXP4986JUb84s/HjfUIPfiUZLyZkeNH
        JfnYiRcum31MvblMoETtuYj8pwIvTAgtVEXf5MSYj4I8cELZxfFtJokrwsfhYceQ
        g431MEgEpaBvV5siv0o+qomrW+ZtBr243rDW4b0qnytDTPYys4Y8+NJ2oJ35jHAp
        +OGMIqHSWnJvkilc4zfyprg5caQg+y/NN0wVTXN3+DLlj5C+ZDIUA+KUBeHWiGUr
        QgZAaY2us6Js4T6gKcHtYrgHa/Wf/mIul2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gs_c8-tZg3-A for <linux-ide@vger.kernel.org>;
        Tue, 12 Apr 2022 20:46:55 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdT6l057nz1Rvlx;
        Tue, 12 Apr 2022 20:46:54 -0700 (PDT)
Message-ID: <751fb5b7-dd6f-6d4d-f69f-7e6a8e091fe3@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 12:46:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <abc9d18a-e0e4-8065-31e9-7936bf0e1e95@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <abc9d18a-e0e4-8065-31e9-7936bf0e1e95@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/13/22 02:26, Sergey Shtylyov wrote:
> sil680_sel{dev|reg}() return a PCI config space address but needlessly
> use the *unsigned long* type for that,  whereas the PCI config space
> accessors take *int* for the address parameter.  Switch these functions
> to returning *int*, updating the local variables at their call sites.
> Get rid of the 'base' local variables in these functions, while at it...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
