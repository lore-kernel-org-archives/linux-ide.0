From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 0/4] drivers/ata: add another IRQ calls
Date: Tue, 16 Jan 2007 19:45:58 +0900
Message-ID: <200701161045.l0GAjnWH009513@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

Dear everyone.

This is the patchset (based on 2.6.20-rc4) for PATA controller
of Celleb. Now, I add two IRQ calls (irq_on, irq_ack) in
ata_port_operations. If these calls are not defined, ata_irq_on()
and ata_irq_ack() are used. Using them, the size of pata_scc.c
is reduced considerably.

I think the abstraction level of these calls are more acceptable
as libata I/F than low-level taskfile accessors.
Please give me any comments.

Best regards,
Akira Iguchi
