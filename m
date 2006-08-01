From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Tue, 01 Aug 2006 20:39:42 +0200
Message-ID: <1154457583.4665.5.camel@shark.pacific>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
Reply-To: roger@opq.se
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8tcVdVxcPA9Rw0d5nXsg"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.surbrunn.net ([195.84.183.170]:35589 "EHLO
	Tule.surbrunn.net") by vger.kernel.org with ESMTP id S1750941AbWHASeo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 14:34:44 -0400
In-Reply-To: <44CF7447.300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-8tcVdVxcPA9Rw0d5nXsg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
> Roger Oberholtzer wrote:
> > Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
> > Family) chipset? I am trying kernel 2.6.17.7
> > 
> > I have been trying the warmplug stuff. But I am not convinced it is 
> > acting as I expect. If I remove a disk and then do a scan, shouldn't
> > the disk entry go away?
> 
> Eventually, yes.  Do you mind to send me the dmesg?

I have picked out the lines related to this. Some of the complaints at
the end are probably when I moved the disk. 

> > I know about the problems with just removing a disk. But this is with
> > one that is not mounted. I just want to see if the disks are properly
> > sensed as coming and going. I am using the warmplug instructions on
> > your web site.
> 
> There are some complications with piix PCS register (port 
> enable/disable) which always seems to have some problem.  If you can use 
> AHCI mode, it will be *much* better.

OK. How do I get it in ahci mode? I see that both the ata_piix and achi
drivers are loaded. This is what is loaded:

Module                  Size  Used by
xfs                   465784  0
af_packet              28040  2
ipv6                  238368  18
nfsd                  202244  9
exportfs                9600  1 nfsd
lockd                  57992  2 nfsd
nfs_acl                 7680  1 nfsd
sunrpc                142524  9 nfsd,lockd,nfs_acl
edd                    12740  0
loop                   18824  0
dm_mod                 54936  0
usbhid                 47328  0
ehci_hcd               32008  0
shpchp                 38304  0
uhci_hcd               24588  0
e1000                 104888  0
pci_hotplug            31548  1 shpchp
usbcore               115968  4 usbhid,ehci_hcd,uhci_hcd
ide_cd                 39712  0
cdrom                  36640  1 ide_cd
i2c_i801               12172  0
i2c_core               23552  1 i2c_i801
parport_pc             39780  1
lp                     15140  0
parport                37320  2 parport_pc,lp
ext3                  125576  2
jbd                    64032  1 ext3
sg                     35996  0
ata_piix               15492  0
ahci                   18436  0
processor              30056  0
libata                 65676  2 ata_piix,ahci
piix                   13444  0 [permanent]
sd_mod                 22656  0
scsi_mod              127624  4 sg,ahci,libata,sd_mod
ide_disk               19072  4
ide_core              118344  3 ide_cd,piix,ide_disk

> If you think the driver doesn't do the right thing(tm), please send me 
> detailed info.  I'll try to fix the problem if possible or explain why 
> it can't be fixed at the very least.

I bet the driver does the right thing. The trick is knowing what that is
supposed to be. And how to use the various commands on files in /sys at
the correct time and in the correct order.

--
Roger Oberholtzer


--=-8tcVdVxcPA9Rw0d5nXsg
Content-Disposition: attachment; filename=m.txt.gz
Content-Type: application/x-gzip; name=m.txt.gz
Content-Transfer-Encoding: base64

H4sICKWez0QAA20udHh0AO2dW2/b2BWF3+dXnLdpgSQSRUmWhU4BJZkWQZvWrdMLEASBLrRDRJY8
JJXELfrfeyh5GlFZR5t7n0X0ZYy5xcn+tkR+XKFHWs5sd+tc4pKL6eByOrhw8zwrE/cxKzbZeuqu
X1y/cuVuUT6UVXbn8k1e5fN1/q9s9d3s7OA6X8yrufuUFWW+3bjk2aDv1tv5Kls9Eyb92Pv7PP/i
+v5j6v9Kbp4Npkek/shGeD27cm/dVd9dDdxV4q5S904AXb145Q9BVlX55tat51W2WT64Kr/LCre9
cavsU77MGktctXXjofzwEo+dvZm5u/kX97eXr2e9JE3d8m7l+l/S/o8Tt6zW+/98+aNb3K3u5vsf
PO+7vPjJJeNLecHg7IL+1wWz4wWT9gt+fgb326JyH+al22wfD4h0fstlmffd17PU/snYdiXHu45+
fTqaJsNT3X//yv3zd9fuc159cLMXfyyfuDJb7oq8evCMqsgXuyrznyyy+br24Im3orjN3GK9XX50
m93dwlv65PD4Fn5Ttpkv1o1rBW2tN95td5u9Zjf5Onu82srVPBFGf9ys6qHlOptvvnLczbY4Ak1P
SaPxdJSekJz7e7ZZbYupqw/14eP1drU/Km/Swag/GQxn148/8dfs09Slz2YzEfrm4T6r//0yL7Jl
9XS2XGZl6eDH7E8+a/aBU/iTW1/sU9e41tGG/a9/vBL9s5y64WSSXl4k44kbJYOni4cqcx9Wn4v6
PFbbonS/8k+lP7p0r5//WkDvcf/w5z5zV8W28vMuL/2Ff9Nmrj50Pjo2pX/2/b5L5/U/+33ts1kV
+afMLefLD57zef9YFvPlx18Oiv6gHGZbXAnlyiVTn+f+bzerqnrNap8kbpWXH2uCGXCbbbIiX7ry
tu8qf2W4r899Mu2n0+HAEg141BINnjTyQcqNhhCUFw14A+UqwGj5KjgzJ10FLZ+NdBX8clBCByX9
+YLd+dHV0+xTtqneDpNR+s7PzPPqvb9G3vvr46Y8/Hh/7fnL5vue/2TvsK7s3S/zx1u/3vEtYO/D
tqySXlXfF1T7GOg9hkFvsSu/dzfz/PiO4PCAxv+fB5Rvs6J4v9xU+GGNvrlm62P8m/S3h3uy5fbu
br6pbymXk/1d8XZX+fulal75T036rt77/vGHw0RAH5BVMd+U9Y32ah819XDPP8Q9zz+p+vZ6f8qv
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



--=-8tcVdVxcPA9Rw0d5nXsg--

