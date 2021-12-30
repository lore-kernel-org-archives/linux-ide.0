Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006EC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 05:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhL3FUm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 00:20:42 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:39438 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231228AbhL3FUm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 00:20:42 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPc6y2DGvz1RtVc
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2021 21:20:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640841642; x=1643433643; bh=oRfC8O8Ofjt54BbMP175nZTVWroI6hBnAva
        xdLCjWPs=; b=Ka8sFoC2K8jxAWUmpfy+xvO5+8GwnjJkp9V6COEwXgD1WH21SU/
        9MGoL/KqC6aBjWsrBfy9SPW2Q2gMz5LcjNaKFqOklnTMflanH1uMON/Vt73YX1lE
        yeoxMkVFLsyuMkhy69D3TWYZoKQ77frJJWZ9zTzWhExgiYFbBy/A7f9ZiL8K39qw
        9v1JCkpU2wzt5P7vBASZfiMXVJ+747Lck/XSFU3HBjGNcEI3JFt5H4kmmbJcGkRt
        aYb2IVbbfepxkUYXlv7oThHzNc6Hd5zx+aItLRcLHE2dKIKsCzhSjkt5FXOR1lkA
        VI88s641RAd01o6t4RPfkQ/Rw8gLB8xumWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cjxXQOqQDGLS for <linux-ide@vger.kernel.org>;
        Wed, 29 Dec 2021 21:20:42 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPc6x49yCz1RtVG;
        Wed, 29 Dec 2021 21:20:41 -0800 (PST)
Message-ID: <51f021db-c55c-74be-46b5-56f48817d12f@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 14:20:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 43/68] libata: drop ata_msg_info()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-44-hare@suse.de>
 <4fd38f6e-b804-1356-9a13-d35f9ddfa660@omp.ru>
 <d5ddd55a-c774-f9db-720c-b8ff4d818c80@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5ddd55a-c774-f9db-720c-b8ff4d818c80@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/24/21 03:47, Sergey Shtylyov wrote:
> On 12/23/21 12:48 PM, Sergey Shtylyov wrote:
>=20
> [...]
>>> Convert the sole caller to ata_dev_deb() and remove the definition.
>>
>> =C2=A0=C2=A0 ata_dev_info() actually (as follows from the patch)?
>=20
>    Sorry, ata_dev_dbg()... :-/

Fixed this when applying to for-5.17-logging.

>=20
>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [...]
>=20
> MBR, Sergey


--=20
Damien Le Moal
Western Digital Research
