From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ata: Allow drivers to build if COMPILE_TEST is enabled
Date: Wed, 14 Oct 2015 03:17:02 +0800
Message-ID: <201510140301.wEELIPeY%fengguang.wu@intel.com>
References: <1444743546-11917-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16847 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbbJMTRg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Oct 2015 15:17:36 -0400
Content-Disposition: inline
In-Reply-To: <1444743546-11917-1-git-send-email-javier@osg.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, Luis de Bethencourt <luisbg@osg.samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Javier,

[auto build test WARNING on tj-libata/for-next -- if it's inappropriate=
 base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Javier-Martinez-Canill=
as/ata-Allow-drivers-to-build-if-COMPILE_TEST-is-enabled/20151013-21413=
8
reproduce:
        # apt-get install sparse
        make ARCH=3Dx86_64 allmodconfig
        make C=3D1 CF=3D-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/ata/sata_fsl.c:428:30: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:428:30:    expected unsigned int [unsigned] [=
usertype] cda
   drivers/ata/sata_fsl.c:428:30:    got restricted __le32 [usertype] <=
noident>
>> drivers/ata/sata_fsl.c:429:39: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:429:39:    expected unsigned int [unsigned] [=
usertype] prde_fis_len
   drivers/ata/sata_fsl.c:429:39:    got restricted __le32 [usertype] <=
noident>
>> drivers/ata/sata_fsl.c:431:30: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:431:30:    expected unsigned int [unsigned] [=
usertype] ttl
   drivers/ata/sata_fsl.c:431:30:    got restricted __le32 [usertype] <=
noident>
>> drivers/ata/sata_fsl.c:432:36: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:432:36:    expected unsigned int [unsigned] [=
usertype] desc_info
   drivers/ata/sata_fsl.c:432:36:    got restricted __le32 [usertype] <=
noident>
>> drivers/ata/sata_fsl.c:484:34: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:484:34:    expected unsigned int [unsigned] [=
usertype] dba
   drivers/ata/sata_fsl.c:484:34:    got restricted __le32 [usertype] <=
noident>
   drivers/ata/sata_fsl.c:491:26: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:491:26:    expected unsigned int [unsigned] [=
usertype] dba
   drivers/ata/sata_fsl.c:491:26:    got restricted __le32 [usertype] <=
noident>
>> drivers/ata/sata_fsl.c:492:34: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:492:34:    expected unsigned int [unsigned] [=
usertype] ddc_and_ext
   drivers/ata/sata_fsl.c:492:34:    got restricted __le32 [usertype] <=
noident>
   drivers/ata/sata_fsl.c:505:54: sparse: incorrect type in assignment =
(different base types)
   drivers/ata/sata_fsl.c:505:54:    expected unsigned int [unsigned] [=
usertype] ddc_and_ext
   drivers/ata/sata_fsl.c:505:54:    got restricted __le32 [usertype] <=
noident>
   drivers/ata/sata_fsl.c:1410:9: sparse: Initializer entry defined twi=
ce
   drivers/ata/sata_fsl.c:1411:10:   also defined here

vim +428 drivers/ata/sata_fsl.c

faf0b2e5 Li Yang            2007-10-16  422 =20
faf0b2e5 Li Yang            2007-10-16  423  	cmd_descriptor_address =3D=
 pp->cmdentry_paddr +
faf0b2e5 Li Yang            2007-10-16  424  	    tag * SATA_FSL_CMD_DE=
SC_SIZE;
faf0b2e5 Li Yang            2007-10-16  425 =20
faf0b2e5 Li Yang            2007-10-16  426  	/* NOTE: both data_xfer_l=
en & fis_len are Dword counts */
faf0b2e5 Li Yang            2007-10-16  427 =20
faf0b2e5 Li Yang            2007-10-16 @428  	pp->cmdslot[tag].cda =3D =
cpu_to_le32(cmd_descriptor_address);
faf0b2e5 Li Yang            2007-10-16 @429  	pp->cmdslot[tag].prde_fis=
_len =3D
faf0b2e5 Li Yang            2007-10-16  430  	    cpu_to_le32((num_prde=
 << 16) | (fis_len << 2));
faf0b2e5 Li Yang            2007-10-16 @431  	pp->cmdslot[tag].ttl =3D =
cpu_to_le32(data_xfer_len & ~0x03);
520d3a1a Li Yang            2007-10-31 @432  	pp->cmdslot[tag].desc_inf=
o =3D cpu_to_le32(desc_info | (tag & 0x1F));
faf0b2e5 Li Yang            2007-10-16  433 =20
faf0b2e5 Li Yang            2007-10-16  434  	VPRINTK("cda=3D0x%x, prde=
_fis_len=3D0x%x, ttl=3D0x%x, di=3D0x%x\n",
faf0b2e5 Li Yang            2007-10-16  435  		pp->cmdslot[tag].cda,
faf0b2e5 Li Yang            2007-10-16  436  		pp->cmdslot[tag].prde_fi=
s_len,
faf0b2e5 Li Yang            2007-10-16  437  		pp->cmdslot[tag].ttl, pp=
->cmdslot[tag].desc_info);
faf0b2e5 Li Yang            2007-10-16  438 =20
faf0b2e5 Li Yang            2007-10-16  439  }
faf0b2e5 Li Yang            2007-10-16  440 =20
faf0b2e5 Li Yang            2007-10-16  441  static unsigned int sata_f=
sl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
2f957fc9 Xulei              2011-01-19  442  				     u32 *ttl, dma_add=
r_t cmd_desc_paddr,
2f957fc9 Xulei              2011-01-19  443  				     int data_snoop)
faf0b2e5 Li Yang            2007-10-16  444  {
faf0b2e5 Li Yang            2007-10-16  445  	struct scatterlist *sg;
faf0b2e5 Li Yang            2007-10-16  446  	unsigned int num_prde =3D=
 0;
faf0b2e5 Li Yang            2007-10-16  447  	u32 ttl_dwords =3D 0;
faf0b2e5 Li Yang            2007-10-16  448 =20
faf0b2e5 Li Yang            2007-10-16  449  	/*
af901ca1 Andr=E9 Goddard Rosa 2009-11-14  450  	 * NOTE : direct & indi=
rect prdt's are contiguously allocated
faf0b2e5 Li Yang            2007-10-16  451  	 */
faf0b2e5 Li Yang            2007-10-16  452  	struct prde *prd =3D (str=
uct prde *)&((struct command_desc *)
faf0b2e5 Li Yang            2007-10-16  453  					    cmd_desc)->prdt;
faf0b2e5 Li Yang            2007-10-16  454 =20
faf0b2e5 Li Yang            2007-10-16  455  	struct prde *prd_ptr_to_i=
ndirect_ext =3D NULL;
faf0b2e5 Li Yang            2007-10-16  456  	unsigned indirect_ext_seg=
ment_sz =3D 0;
faf0b2e5 Li Yang            2007-10-16  457  	dma_addr_t indirect_ext_s=
egment_paddr;
ff2aeb1e Tejun Heo          2007-12-05  458  	unsigned int si;
faf0b2e5 Li Yang            2007-10-16  459 =20
b1f5dc48 Anton Vorontsov    2008-02-22  460  	VPRINTK("SATA FSL : cd =3D=
 0x%p, prd =3D 0x%p\n", cmd_desc, prd);
faf0b2e5 Li Yang            2007-10-16  461 =20
faf0b2e5 Li Yang            2007-10-16  462  	indirect_ext_segment_padd=
r =3D cmd_desc_paddr +
faf0b2e5 Li Yang            2007-10-16  463  	    SATA_FSL_CMD_DESC_OFF=
SET_TO_PRDT + SATA_FSL_MAX_PRD_DIRECT * 16;
faf0b2e5 Li Yang            2007-10-16  464 =20
ff2aeb1e Tejun Heo          2007-12-05  465  	for_each_sg(qc->sg, sg, q=
c->n_elem, si) {
faf0b2e5 Li Yang            2007-10-16  466  		dma_addr_t sg_addr =3D s=
g_dma_address(sg);
faf0b2e5 Li Yang            2007-10-16  467  		u32 sg_len =3D sg_dma_le=
n(sg);
faf0b2e5 Li Yang            2007-10-16  468 =20
f48c019f Kumar Gala         2009-05-13  469  		VPRINTK("SATA FSL : fill=
_sg, sg_addr =3D 0x%llx, sg_len =3D %d\n",
f48c019f Kumar Gala         2009-05-13  470  			(unsigned long long)sg_=
addr, sg_len);
faf0b2e5 Li Yang            2007-10-16  471 =20
faf0b2e5 Li Yang            2007-10-16  472  		/* warn if each s/g elem=
ent is not dword aligned */
6b4b8fc8 Qiang Liu          2012-02-15  473  		if (unlikely(sg_addr & 0=
x03))
a9a79dfe Joe Perches        2011-04-15  474  			ata_port_err(qc->ap, "s=
/g addr unaligned : 0x%llx\n",
f48c019f Kumar Gala         2009-05-13  475  				     (unsigned long lo=
ng)sg_addr);
6b4b8fc8 Qiang Liu          2012-02-15  476  		if (unlikely(sg_len & 0x=
03))
a9a79dfe Joe Perches        2011-04-15  477  			ata_port_err(qc->ap, "s=
/g len unaligned : 0x%x\n",
a9a79dfe Joe Perches        2011-04-15  478  				     sg_len);
faf0b2e5 Li Yang            2007-10-16  479 =20
37198e30 James Bottomley    2008-02-05  480  		if (num_prde =3D=3D (SAT=
A_FSL_MAX_PRD_DIRECT - 1) &&
37198e30 James Bottomley    2008-02-05  481  		    sg_next(sg) !=3D NUL=
L) {
faf0b2e5 Li Yang            2007-10-16  482  			VPRINTK("setting indire=
ct prde\n");
faf0b2e5 Li Yang            2007-10-16  483  			prd_ptr_to_indirect_ext=
 =3D prd;
faf0b2e5 Li Yang            2007-10-16 @484  			prd->dba =3D cpu_to_le3=
2(indirect_ext_segment_paddr);
faf0b2e5 Li Yang            2007-10-16  485  			indirect_ext_segment_sz=
 =3D 0;
faf0b2e5 Li Yang            2007-10-16  486  			++prd;
faf0b2e5 Li Yang            2007-10-16  487  			++num_prde;
faf0b2e5 Li Yang            2007-10-16  488  		}
faf0b2e5 Li Yang            2007-10-16  489 =20
faf0b2e5 Li Yang            2007-10-16  490  		ttl_dwords +=3D sg_len;
faf0b2e5 Li Yang            2007-10-16  491  		prd->dba =3D cpu_to_le32=
(sg_addr);
2f957fc9 Xulei              2011-01-19 @492  		prd->ddc_and_ext =3D cpu=
_to_le32(data_snoop | (sg_len & ~0x03));
faf0b2e5 Li Yang            2007-10-16  493 =20
faf0b2e5 Li Yang            2007-10-16  494  		VPRINTK("sg_fill, ttl=3D=
%d, dba=3D0x%x, ddc=3D0x%x\n",
faf0b2e5 Li Yang            2007-10-16  495  			ttl_dwords, prd->dba, p=
rd->ddc_and_ext);

:::::: The code at line 428 was first introduced by commit
:::::: faf0b2e5afe7dae072d2715763c7f992b612b628 drivers/ata: add suppor=
t to Freescale 3.0Gbps SATA Controller

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

---
0-DAY kernel test infrastructure                Open Source Technology =
Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corpo=
ration
