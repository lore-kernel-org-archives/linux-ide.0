From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: Remove bogus cable match
Date: Tue, 09 Dec 2008 00:48:04 -0500
Message-ID: <493E0694.9030609@garzik.org>
References: <20081205194117.17036.74479.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54688 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYLIFsL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 00:48:11 -0500
In-Reply-To: <20081205194117.17036.74479.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Some systems report SIS 5513 as both vendor/id and subvendor/id string. In
> that case we can't distinguish the system by the id svid/sdid and in fact
> the entry here breaks some boxes. At some point we need to find another way
> to detect the Targa Visionary 1000, until then this a hang for some users with
> lower performance for others.
> 
> Closes: #12092
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/ata/pata_sis.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
> index d342366..e4be55e 100644
> --- a/drivers/ata/pata_sis.c
> +++ b/drivers/ata/pata_sis.c
> @@ -56,7 +56,6 @@ static const struct sis_laptop sis_laptop[] = {
>  	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
>  	{ 0x5513, 0x1734, 0x105F },	/* FSC Amilo A1630 */
>  	{ 0x5513, 0x1071, 0x8640 },     /* EasyNote K5305 */
> -	{ 0x5513, 0x1039, 0x5513 },	/* Targa Visionary 1000 */
>  	/* end marker */

applied #upstream-fixes


