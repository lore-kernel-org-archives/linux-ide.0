From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] siimage: coding style cleanup (take 2)
Date: Sun, 27 Apr 2008 20:37:06 +0200
Message-ID: <200804272037.06406.bzolnier@gmail.com>
References: <200804222056.38802.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:25372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762371AbYD0TyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628224fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:16 -0700 (PDT)
In-Reply-To: <200804222056.38802.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 22 April 2008, Sergei Shtylyov wrote:
> Fix 18 errors and several warnings given by checkpatch.pl:
> 
> - use of C99 // comments;
> 
> - trailing whitespace;
> 
> - 'switch' and 'case' not at the same indentation level;
> 
> - no space before the open parenthesis of the 'if' and 'switch' statements;
> 
> - space between function name and open parenthesis (though I have introduced
>   such warnins in some places since the code looks prettier with the spaces);
> 
> - including <asm/io.h> instead of <linux/io.h>;
> 
> - line over 80 characters.
> 
> In addition to these changes, also do the following:
> 
> - make the arrays in sil_set_pio_mode() 'static', and make the arrays in
>   sil_set_dma_mode() 'static const';
> 
> - change the string of the 'if' statements into the 'switch' statement in
>   sil_pata_udma_filter();
> 
> - drop the needless '==' operators from the 'if' statements where a condition
>   is a mere bit test;
> 
> - remove needless initializer for the 'tmp' variable in init_chipset_siimage();
> 
> - beautify groups of the variable initializers and assignment operators;
> 
> - add new line after variable definitions;
> 
> - remove new line between the comment and the statements it refers to;
> 
> - remove needless curly braces and parentheses;
> 
> - fix typos, capitalize acronyms, etc. in the comments...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
