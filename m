From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [m68k] drivers/ide/ide-taskfile.c:235: error: implicit declaration
 of function 'sg_page'
Date: Sun, 15 Jun 2008 15:43:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806151538160.5736@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-next@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

	Hi Bart,

As of June 12, drivers/ide/ide-taskfile.c fails to compile on m68k in
linux-next:

| drivers/ide/ide-taskfile.c:235: error: implicit declaration of function 'sg_page'
| drivers/ide/ide-taskfile.c:251: error: implicit declaration of function 'sg_next'
| distcc[17810] ERROR: compile drivers/ide/ide-taskfile.c on localhost failed
| make[3]: *** [drivers/ide/ide-taskfile.o] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/31729/

I suspect http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=52cc802c0f45d8c15b20025e0fecf84174797307 is too blame:

| ide: remove needless includes from ide-taskfile.c

| -#include <linux/scatterlist.h>
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
As ide-taskfile.c uses scatterlists, it should include <linux/scatterlist.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
