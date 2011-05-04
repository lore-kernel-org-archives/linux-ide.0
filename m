From: shaohua.li@intel.com
Subject: [patch v2 0/3] block: optimize flush for non-queueable flush drive
Date: Wed, 04 May 2011 16:17:25 +0800
Message-ID: <20110504081725.946950281@sli10-conroe.sh.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jaxboe@fusionio.com, htejun@gmail.com, jgarzik@pobox.com, hch@infradead.org, djwong@us.ibm.com
List-Id: linux-ide@vger.kernel.org

Flush request isn't queueable. When it's running, other request
can't. We can optimize flush performance according to this knowledge
In my test, I got about 20% performance boost.
