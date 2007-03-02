From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [PATCH] libata Kconfig: Update the various experimentality levels
Date: Fri, 2 Mar 2007 15:32:01 +0000
Message-ID: <200703021532.02215.s0348365@sms.ed.ac.uk>
References: <20070302150512.281af8d3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992522AbXCBPcM@vger.kernel.org>
In-Reply-To: <20070302150512.281af8d3@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday 02 March 2007 15:05, you wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
[snip]
>  config PATA_OLDPIIX
> -	tristate "Intel PATA old PIIX support (Experimental)"
> +	tristate "Intel PATA support for the original PIIX"
>  	depends on PCI && EXPERIMENTAL
>  	help
> -	  This option enables support for old(?) PIIX PATA support.
> +	  This option enables support for early Intel PIIX PATA support.

Probably nothing, but is it intentional to remove the "(Experimental)" text 
here, but not the dependency on EXPERIMENTAL?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
