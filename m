From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCHSET] libata: PATA driver
	for Celleb
Date: Fri, 26 Jan 2007 16:24:46 +0900
Message-ID: <200701260724.l0Q7OIBB016333@toshiba.co.jp>
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

Thank you for many useful comments.
This is the latest patchset for the PATA controller of Celleb. 

This patchset consists of
[1] add another IRQ calls (core and headers)
[2] add another IRQ calls (libata drivers)
[3] PATA driver for Celleb

And patch[3] depends on patch[1,2].

This patchset is based on the Tejun's "devres" git tree, which is
available at the followin URL.

http://htj.dyndns.org/git/?p=libata-tj.git;a=commit;h=efc6607aefe728b2721f6a0126bc527bc23eb46f


Best regards,
Akira Iguchi
