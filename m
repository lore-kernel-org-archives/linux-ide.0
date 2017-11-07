From: Anurag Kumar Vulisha <anuragku@xilinx.com>
Subject: RE: [bug report] ata: ceva: Move sata port phy oob settings to
 device-tree
Date: Tue, 7 Nov 2017 12:31:02 +0000
Message-ID: <MWHPR02MB281604ACADBD9405348BB615A7510@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <20171107114142.x6bufnfrr5bnb4vg@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:54304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753569AbdKGMbF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 7 Nov 2017 07:31:05 -0500
In-Reply-To: <20171107114142.x6bufnfrr5bnb4vg@mwanda>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>

+ Michal

Hi Dan,

Please find my comments inline

>-----Original Message-----
>From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
>Sent: Tuesday, November 07, 2017 5:12 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>Cc: linux-ide@vger.kernel.org
>Subject: [bug report] ata: ceva: Move sata port phy oob settings to device=
-tree
>
>Hello Anurag Kumar Vulisha,
>
>The patch fe8365bbf8ac: "ata: ceva: Move sata port phy oob settings to dev=
ice-
>tree" from Aug 21, 2017, leads to the following static checker warning:
>
>	drivers/ata/ahci_ceva.c:273 ceva_ahci_probe()
>	warn: passing casted pointer '&cevapriv->pp5c[1]' to
>'of_property_read_u16_array()' 32 vs 16.
>
>drivers/ata/ahci_ceva.c
>   260          if (of_property_read_u8_array(np, "ceva,p1-burst-params",
>   261                                          (u8 *)&cevapriv->pp4c[1], =
4) < 0) {
>   262                  dev_warn(dev, "ceva,p1-burst-params property not d=
efined\n");
>   263                  return -EINVAL;
>   264          }
>   265
>   266          /* Read phy RETRY interval timing value from device-tree *=
/
>   267          if (of_property_read_u16_array(np, "ceva,p0-retry-params",
>   268                                          (u16 *)&cevapriv->pp5c[0],=
 2) < 0) {
>                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
>
>   269                  dev_warn(dev, "ceva,p0-retry-params property not d=
efined\n");
>   270                  return -EINVAL;
>   271          }
>   272
>   273          if (of_property_read_u16_array(np, "ceva,p1-retry-params",
>   274                                          (u16 *)&cevapriv->pp5c[1],=
 2) < 0) {
>                                                ^^^^^^^^^^^^^^^^^^^^^^^^^
>
>I'm confused what's going on here.  We're reading two arrays of u16 into a=
n
>array of u32.  Why are we not just reading 2 separate u32 values?
>Does this code have to work on big endian systems because I bet it doesn't=
.
>

[Anurag Kumar Vulisha] Yes we are reading two u16 values into a u32. This i=
s because we have two 16bit values RIT & RCT which gets genreated based on =
the SATA refclk being used . As we have different platforms which are using=
 different sata  refclk and also each port can operate on different refclk,=
  we read the two u16 values from DT node and update it in the vendor contr=
ol register. The below is the example of the RIT & RCT values that has been=
 updated in the ahci-ceva.txt

- ceva,p0-retry-params: Retry interval timing value for port 0.            =
  =20
                        The fields for the above parameter must be as shown=
 below:
                        ceva,phy-retry-params =3D /bits/ 16 <RIT RCT>;     =
      =20
                        RIT:  Retry Interval Timer.                        =
    =20
                        RCT:  Rate Change Timer.
Example:
ceva,p0-retry-params =3D /bits/ 16 <0x0216 0x7F06>;

Thanks,
Anurag Kumar Vulisha

>   275                  dev_warn(dev, "ceva,p1-retry-params property not d=
efined\n");
>   276                  return -EINVAL;
>   277          }
>   278
>
>regards,
>dan carpenter
