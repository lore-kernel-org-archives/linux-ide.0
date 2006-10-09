From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6.19 patch] ATA must depend on BLOCK
Date: Mon, 09 Oct 2006 15:08:37 +0200
Message-ID: <452A49D5.4060904@s5r6.in-berlin.de>
References: <20061008231621.GM6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932798AbWJINIk@vger.kernel.org>
In-Reply-To: <20061008231621.GM6755@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> This patch fixes the following compile error with CONFIG_ATA=y, 
> CONFIG_BLOCK=n:
[...]
>  config ATA
>  	tristate "ATA device support"
> +	depends on BLOCK
>  	depends on !(M32R || M68K) || BROKEN
>  	depends on !SUN4 || BROKEN
>  	select SCSI

The Kconfig isn't broken but the tool which generated the .config.

"config ATA\ select SCSI" implies a dependency of ATA on SCSI. SCSI
depends on BLOCK.

Therefore "select SCSI" && "config SCSI\ depends on BLOCK" implies
either "config ATA\ select BLOCK" or "config ATA\ depends on BLOCK".

{Ignore all what I said if ATA code directly uses the block API. Usages
of the block API to manipulate SCSI data structures, particularly the
request queue, does not necessarily count as independent usage of the
block API though.}
-- 
Stefan Richter
-=====-=-==- =-=- -=---
http://arcgraph.de/sr/
