From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 14:15:12 +0000
Message-ID: <20061204141512.0eba89f9@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Mon, 4 Dec 2006 14:25:04 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> But 0 _is_ a valid PCI I/O address.  Do we now have to start
> using "virtual I/O addresses", analogue to the IRQ situation,
> or can these bad assumptions be fixed instead?

Send patches to Bartlomiej now he is back in circulation.

Alan
