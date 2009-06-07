From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.30-rc8 BUG: unable to handle kernel NULL pointer dereference
Date: Sun, 7 Jun 2009 15:07:54 +0200
Message-ID: <200906071507.54183.bzolnier@gmail.com>
References: <4A2A95B6.2050406@science.uva.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:37756 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbZFGNo4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 09:44:56 -0400
Received: by mail-fx0-f213.google.com with SMTP id 9so1594329fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Jun 2009 06:44:58 -0700 (PDT)
In-Reply-To: <4A2A95B6.2050406@science.uva.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wouter Koolen-Wijkstra <wmkoolen@science.uva.nl>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Saturday 06 June 2009 18:13:42 Wouter Koolen-Wijkstra wrote:
> Dear IDE maintainers,
> 
> Linux 2.6.30-rc8 oopses after booting.
> 
> When I boot 2.6.30-rc8, it consistently hits a nullpointer dereference.
> Attached you find a photograph of the stacktrace dumped to screen. It
> does not get written to the log files. You'll also find my kernel
> config, cpuinfo and lspci output.
> 
> Earlier kernels (e.g. 2.6.29.4) boot fine.

This seems to be the same problem as the one already tracked in:

	http://bugzilla.kernel.org/show_bug.cgi?id=13399

and we need some more information to be able to find the root cause of it
(please see bugzilla entry for details).

Thanks.
Bart
