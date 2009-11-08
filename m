From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: ata_sff_data_xfer* return value
Date: Sun, 08 Nov 2009 20:27:02 +0100
Message-ID: <m37hu0bywp.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:53943 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbZKHT07 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Nov 2009 14:26:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hi,

I wonder if this is entirely correct? If so, why?
Only relevant parts left.

 *	RETURNS:
 *	Bytes consumed.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 */
unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
			       unsigned int buflen, int rw)
{
	unsigned int words = buflen >> 1;

	...

	/* Transfer trailing byte, if any. */
	if (unlikely(buflen & 0x01)) {
		...
		words++;
	}

	return words << 1;



same here:

unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
			       unsigned int buflen, int rw)
{
	...
	return (buflen + 1) & ~1;

Please keep me in CC:, I'm not on the IDE list. Thanks.
-- 
Krzysztof Halasa
