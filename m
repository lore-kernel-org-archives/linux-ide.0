From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 04:39:44 +0100
Message-ID: <20070326033944.GA13395@srcf.ucam.org>
References: <20070326032222.GA13113@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:53955 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504AbXCZDj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Mar 2007 23:39:57 -0400
Content-Disposition: inline
In-Reply-To: <20070326032222.GA13113@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kristen.c.accardi@intel.com

> +                printk(KERN_ERR
> +                        "%s: unexpected _GTM length (0x%x)[should be 0x%zx] or \
> +"
> +		       "addr (0x%p)\n",
> +		       __FUNCTION__, out_obj->buffer.length,
> +		       sizeof(struct GTM_buffer), out_obj->buffer.pointer);

Yeah, erm.

> + * _STM requires Identify Drive data, which has to passed as an argument.
> + * Unfortunately hd_driveid is a mangled version which we can't readily
> + * use; hence we'll get the information afresh.

And clearly this doesn't actually match reality either. I'll send a 
tidied up patch when I've actually slept.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
