From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ata: ceva: Move sata port phy oob settings to
 device-tree
Date: Tue, 7 Nov 2017 14:41:43 +0300
Message-ID: <20171107114142.x6bufnfrr5bnb4vg@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51077 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbdKGLly (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2017 06:41:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: anurag.kumar.vulisha@xilinx.com
Cc: linux-ide@vger.kernel.org

Hello Anurag Kumar Vulisha,

The patch fe8365bbf8ac: "ata: ceva: Move sata port phy oob settings
to device-tree" from Aug 21, 2017, leads to the following static
checker warning:

	drivers/ata/ahci_ceva.c:273 ceva_ahci_probe()
	warn: passing casted pointer '&cevapriv->pp5c[1]' to 'of_property_read_u16_array()' 32 vs 16.

drivers/ata/ahci_ceva.c
   260          if (of_property_read_u8_array(np, "ceva,p1-burst-params",
   261                                          (u8 *)&cevapriv->pp4c[1], 4) < 0) {
   262                  dev_warn(dev, "ceva,p1-burst-params property not defined\n");
   263                  return -EINVAL;
   264          }
   265  
   266          /* Read phy RETRY interval timing value from device-tree */
   267          if (of_property_read_u16_array(np, "ceva,p0-retry-params",
   268                                          (u16 *)&cevapriv->pp5c[0], 2) < 0) {
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   269                  dev_warn(dev, "ceva,p0-retry-params property not defined\n");
   270                  return -EINVAL;
   271          }
   272  
   273          if (of_property_read_u16_array(np, "ceva,p1-retry-params",
   274                                          (u16 *)&cevapriv->pp5c[1], 2) < 0) {
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^

I'm confused what's going on here.  We're reading two arrays of u16 into
an array of u32.  Why are we not just reading 2 separate u32 values?
Does this code have to work on big endian systems because I bet it
doesn't.

   275                  dev_warn(dev, "ceva,p1-retry-params property not defined\n");
   276                  return -EINVAL;
   277          }
   278  

regards,
dan carpenter
