From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 07 Jul 2007 20:51:56 +0400
Message-ID: <468FC4AC.9030701@ru.mvista.com>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200707071419.52650.arnd@arndb.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Arnd Bergmann wrote:

>>This adds support for MMIO IDE device like CompactFlash 
>>in TrueIDE mode.

>>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
>>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

> Hmm, are we still adding new IDE drivers? Do you also have a

    Yes, why not?

> driver for the new libata layer?

    No (sorry for replying for Vitaly but I know the situation).

> I think it would even be simpler to do.

    Wel have no interest in it right now.

> You could also make it an of_platform_driver at the same time
> instead of adding more cruft to fsl_soc.c. Since we're already

    That's a fair point (and fsl_soc.c doesn't seem proper place anyway).

> about to add the electra_ide.c driver in 2.6.23, I guess there
> should really be _one_ driver that is able to handle all
> of_device based ATA hosts.

    One driver to rule them all. :-)
    That may be not so simple as it seems...

MBR, Sergei
