From: "Luiz Fernando N. Capitulino" <lcapitulino@terra.com.br>
Subject: Re: [Kernel-janitors] [patch] MIN/MAX in ide-timing.h
Date: Sat, 10 Jul 2004 10:55:29 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040710105529.22e81954.lcapitulino@terra.com.br>
References: <20040708181843.GA1370@moley.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from loncoche.terra.com.br ([200.154.55.229]:15525 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S266252AbUGJODc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2004 10:03:32 -0400
In-Reply-To: <20040708181843.GA1370@moley.homelinux.net>
List-Id: linux-ide@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
Cc: vojtech@suse.cz, linux-ide@vger.kernel.org, kernel-janitors@lists.osdl.org, lcapitulino@prefeitura.sp.gov.br


 Hello Clemens,

 The patch seems right to me, but I have some comments:

Em Thu, 8 Jul 2004 20:18:43 +0200
Clemens Buchacher <drizzd@aon.at> screveu:

| # This is a BitKeeper generated diff -Nru style patch.

[...]

 
| -#define MIN(a,b)	        ((a)<(b)?(a):(b))
| -#define MAX(a,b)	        ((a)>(b)?(a):(b))
| -#define FIT(v,min,max)	MAX(MIN(v,max),min)
| -#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
| -#define EZ(v,unit)	        ((v)?ENOUGH(v,unit):0)
| +#define FIT(v,vmin,vmax)	max(min(v,vmax),vmin)
| +#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
| +#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)

 Did you changed something in ENOUGH and EZ ?

 Maybe we can try to make it inlined functions, thus maybe is possible to
solve the warning problem.

PS: Try to send your patches in the body of the e-mail.

-- 
Luiz Fernando
