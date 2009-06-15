From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sgiioc4: coding style cleanup
Date: Mon, 15 Jun 2009 18:32:51 +0200
Message-ID: <200906151832.51733.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906112154.40247.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35402 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763231AbZFOQt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 12:49:28 -0400
Received: by mail-ew0-f210.google.com with SMTP id 6so5181824ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 15 Jun 2009 09:49:30 -0700 (PDT)
In-Reply-To: <200906112154.40247.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 11 June 2009 19:54:40 Sergei Shtylyov wrote:
> Fix several errors and warnings given by checkpatch.pl:
> 
> - space between the asterisk and parameter name;
> 
> - inconsistent spacing between operator and operands;
> 
> - space between *sizeof* and open parenthesis;
> 
> - #include <asm/io.h> instead of #include <linux/io.h>
> 
> - use of *typedef* instead of a structure tag;
> 
> - line over 80 characters.
> 
> In addition to these changes, also do the following:
> 
> - indent with tabs instead of spaces;
> 
> - put the function's result type and name/parameters on the same line;
> 
> - join back the needlessly broken lines;
> 
> - get rid of needless type cast in sgiioc4_checkirq();
> 
> - remove space between the type cast and the variable name;
> 
> - remove commented out field initializer;
> 
> - uppercase the acronyms, lowercase the normal words in the comments;
> 
> - fix up the multi-line comment style...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
