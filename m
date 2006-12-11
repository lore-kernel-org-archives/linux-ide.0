From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
	DMA_NONE
Date: Mon, 11 Dec 2006 15:18:46 +0100
Message-ID: <200612111518.46887.arnd@arndb.de>
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
	<20061211140258.GB18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 11 December 2006 15:02, Tejun Heo wrote:
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct scatterlist sg;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int n_elem =3D 0;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0sg_init_one(&sg, buf, buflen);
> +=A0=A0=A0=A0=A0=A0=A0if (dma_dir !=3D DMA_NONE) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0WARN_ON(!buf);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sg_init_one(&sg, buf, bufle=
n);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0n_elem++;
> +=A0=A0=A0=A0=A0=A0=A0}
> =A0
Ok, looks good as well. I still think we should have the WARN_ON()
in sg_set_buf(), but I can send a separate patch for that to linux-mm.

	Arnd <><
