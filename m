From: "Luiz Fernando N. Capitulino" <lcapitulino@terra.com.br>
Subject: Re: [patch] MIN/MAX in ide-timing.h
Date: Sun, 11 Jul 2004 10:09:27 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040711100927.3a9e628d.lcapitulino@terra.com.br>
References: <20040708181843.GA1370@moley.homelinux.net>
	<20040710105529.22e81954.lcapitulino@terra.com.br>
	<20040711091249.GG1991@moley.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linares.terra.com.br ([200.154.55.228]:25044 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S266590AbUGKNR2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2004 09:17:28 -0400
In-Reply-To: <20040711091249.GG1991@moley.homelinux.net>
List-Id: linux-ide@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
Cc: vojtech@suse.cz, linux-ide@vger.kernel.org, kernel-janitors@lists.osdl.org

Em Sun, 11 Jul 2004 11:12:50 +0200
Clemens Buchacher <drizzd@aon.at> screveu:

| On Sat, Jul 10, 2004 at 10:55:29AM -0300, Luiz Fernando N. Capitulino wrote:
| > | -#define MIN(a,b)	        ((a)<(b)?(a):(b))
| > | -#define MAX(a,b)	        ((a)>(b)?(a):(b))
| > | -#define FIT(v,min,max)	MAX(MIN(v,max),min)
| > | -#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
| > | -#define EZ(v,unit)	        ((v)?ENOUGH(v,unit):0)
| > | +#define FIT(v,vmin,vmax)	max(min(v,vmax),vmin)
| > | +#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
| > | +#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
| > 
| >  Did you changed something in ENOUGH and EZ ?
| 
| Yes, I added an additional tab to line up with the FIT definition.
| 
| >  Maybe we can try to make it inlined functions, thus maybe is possible to
| > solve the warning problem.
| 
| That's fine too.


 I just read the Vojtech's sugestion after I send this e-mail, I think
he's tip is very better (more simple, less changes).

 Sorry for that.

-- 
Luiz Fernando
