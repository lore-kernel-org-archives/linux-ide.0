From: shaohua.li@intel.com
Subject: [patch v3 0/3] block: optimize flush for non-queueable flush drive
Date: Thu, 05 May 2011 09:59:32 +0800
Message-ID: <20110505015932.306763905@sli10-conroe.sh.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jaxboe@fusionio.com, htejun@gmail.com, hch@infradead.org, jgarzik@pobox.com, djwong@us.ibm.com, sshtylyov@mvista.com
List-Id: linux-ide@vger.kernel.org

Flush request isn't queueable. When it's running, other request
can't. We can optimize flush performance according to this knowledge
In my test, I got about 20% performance boost.

v2->v3: mainly adds more comments to explain the optimization and changes
the code position to enable the optimization in SATA.
