From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/3] 2.6.22-rc3: known regressions v2
Date: Fri, 01 Jun 2007 14:20:55 +0200
Message-ID: <46600F27.1090202__1528.44975605166$1180700939$gmane$org@googlemail.com>
References: <465FED20.3090206@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <465FED20.3090206@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Robert de Rooy <robert.de.rooy@gmail.com>, sparclinux@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-scsi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>, linux-pcmcia@lists.infradead.org, Vivek Goyal <vgoyal@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Mark Salyzyn <aacraid@adaptec.com>, Gregor Jasny <gjasny@googlemail.com>, Yinghai Lu <yhlu.kernel@gmail.com>, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



PCMCIA

Subject    : libata and legacy ide pcmcia failure
References : http://lkml.org/lkml/2007/5/17/305
Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
Status     : Unknown



SATA/PATA

Subject    : 22-rc3 broke the CDROM in Dell notebook
References : http://lkml.org/lkml/2007/5/27/63
Submitter  : Gregor Jasny <gjasny@googlemail.com>
Handled-By : Tejun Heo <htejun@gmail.com>
             Jeff Garzik <jeff@garzik.org>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit d4b2bab4f26345ea1803feb23ea92fbe3f6b77bc
Status     : problem is being debugged



SCSI

Subject    : aacraid: adapter kernel panic'd fffffffd (kexec)
References : http://lkml.org/lkml/2007/5/29/491
Submitter  : Yinghai Lu <yhlu.kernel@gmail.com>
Handled-By : Salyzyn, Mark <mark_salyzyn@adaptec.com>
             Vivek Goyal <vgoyal@in.ibm.com>
Status     : problem is being debugged



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
