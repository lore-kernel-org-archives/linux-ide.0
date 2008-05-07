From: "Bart Van Assche" <bart.vanassche@gmail.com>
Subject: Re: Compact Flash Question
Date: Wed, 7 May 2008 08:15:23 +0200
Message-ID: <e2e108260805062315n15e84abck5f4207a6a7a11805@mail.gmail.com>
References: <005b01c8afc4$77f4ec90$6401a8c0@techwriter>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761627AbYEGGPn@vger.kernel.org>
In-Reply-To: <005b01c8afc4$77f4ec90$6401a8c0@techwriter>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Yigal Sadgat <YSadgat1@gcte.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jwboyer@linux.vnet.ibm.com, joern@logfs.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 6, 2008 at 11:59 PM, Yigal Sadgat <YSadgat1@gcte.com> wrote:
> (2) An engineer at SanDisk Engineering told me NOT to do wear leveling.
> The file allocation table is written very frequently back into the flash. So
> is it really safe to assume that I don't need wear leveling???

For most Linux filesystems you really need wear leveling. E.g. ext3's
superblock is at a fixed location and gets overwritten frequently.
Without wear leveling you risk that the flash sector where the
superblock resides wears out early.

When using ext3 on a CompactFlash, you can limit the number of writes
to the CompactFlash significantly by mounting the medium with
parameters like noatime,nodiratime,commit=300.

Bart.
