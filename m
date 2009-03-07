From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH resend] au1xxx-ide: auide_{in|out}sw() should be static
Date: Sat, 7 Mar 2009 17:06:10 +0100
Message-ID: <200903071706.12303.bzolnier@gmail.com>
References: <200903061725.48732.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:44411 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbZCGQYV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Mar 2009 11:24:21 -0500
Received: by fk-out-0910.google.com with SMTP id f33so321107fkf.5
        for <linux-ide@vger.kernel.org>; Sat, 07 Mar 2009 08:24:19 -0800 (PST)
In-Reply-To: <200903061725.48732.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 06 March 2009, Sergei Shtylyov wrote:
> Make auide_{insw|outsw}() 'static' and mark them 'inline' as there's only one
> call site for each: in the driver's {in|out}put_data() methods respectively...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
