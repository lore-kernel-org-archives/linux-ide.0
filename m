From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Date: Thu, 11 Jan 2007 18:30:55 +0900
Message-ID: <200701110928.l0B9SUri015056@toshiba.co.jp>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: (Your message of "Thu, 11 Jan 2007 10:08:34 +0100")
	<200701111008.34866.arnd@arndb.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hi, Arnd-san.

Thank you for checking our patches.

>On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
>> This patch modifies some static functions in libata-core.c
>> and libata.h to use them in ata_scc.c.
>
>Exporting new symbols needs some explanation here about why they
>should now be global for ata_scc while the existing drivers
>did not need them. Since the patch otherwise only moves stuff
>around as needed, I assume it's good.

I thought it was better to use common functions as far as possible.
But if it is preferable to copy them in ata_scc.c, I will do so.

Best regards,
Akira Iguchi
