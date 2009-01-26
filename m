From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 22:28:51 +0300
Message-ID: <497E0EF3.2000201@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com> <20090126190801.7d198246@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3857 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751785AbZAZT2W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:28:22 -0500
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

    And did that completely correctly.

> This patch keeps the version checks but incorporates the other suggestions
> Sergei made including a better ata version check for the usual case where
> we want to know "is version >= x" rather than "what version do you
> support".

    Improvements should be mixed with fixes.

> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

    NAK.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 88c2428..c17b62a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index a53318b..e35d8de 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
[...]
> @@ -734,15 +741,16 @@ static inline int ata_id_is_cfa(const u16 *id)
>  	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
>  		return 1;
>  	/* Could be CF hiding as standard ATA */
> -	if (ata_id_major_version(id) >= 3 &&
> -	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
> -	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
> +	if (ata_id_has_version(id, 3) &&

    Refer to the CF specs (google for cfspc<x_><y>.pdf) as to why it's wrong.

WBR, Sergei
