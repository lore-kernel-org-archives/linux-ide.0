From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 22:31:02 +0300
Message-ID: <497E0F76.6020606@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com> <20090126190801.7d198246@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3883 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751870AbZAZTac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:30:32 -0500
In-Reply-To: <20090126190801.7d198246@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:
> This is what I would favour:

> libata: Fix CFA detection & improve version inlines

> From: Alan Cox <alan@redhat.com>

> Sergei Shtylyov noticed thae ata_id_is_cfa checked the wrong word for the
> secondary CFA test and posted a patch set to improve this, but which
> removed the version checks.

> This patch keeps the version checks but incorporates the other suggestions
> Sergei made including a better ata version check for the usual case where
> we want to know "is version >= x" rather than "what version do you
> support".

> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index a53318b..e35d8de 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -675,6 +675,13 @@ static inline unsigned int ata_id_major_version(const u16 *id)
>  	return mver;
>  }
>  
> +static inline int ata_id_has_version(const u16 *id, int v)
> +{
> +	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
> +		return 0;
> +	return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;

    Refer to afa_dev_cf_sata() on how it's done in really optimal way.

WBR, Sergei
