From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Fri, 12 Jan 2007 19:00:45 +0900
Message-ID: <200701120958.l0C9wIPA026082@toshiba.co.jp>
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
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: linux-ide@vger.kernel.org

Dear everyone,

This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
which access the taskfile registers. The idea comes from drivers/ide
IN*/OUT* calls.

As you know, these calls are unnecessary for most libata drivers.
But the Celleb PATA driver needs them to use the libata common code.
And using these calls, it is possible to remove similar code
about PIO/MMIO access.

Please give me any comments.

Best regards,
Akira Iguchi
