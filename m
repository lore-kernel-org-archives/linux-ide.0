From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] pata_platform: fix devres conversion
Date: Fri, 02 Feb 2007 11:55:44 -0500
Message-ID: <45C36D10.3030809@garzik.org>
References: <11692764264005-git-send-email-htejun@gmail.com> <45C0827C.2050207@garzik.org> <20070201060522.GK8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945988AbXBBQzu@vger.kernel.org>
In-Reply-To: <20070201060522.GK8606@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> devres updates for pata_platform were dropped while merging devres
> patches due to merge conflict.  This is the updated version.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2
