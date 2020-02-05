Return-Path: <SRS0=KtmC=3Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B3C35247
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 01:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308942082E
	for <linux-ide@archiver.kernel.org>; Wed,  5 Feb 2020 01:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgBEBwa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:52:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:53681 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgBEBwa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 20:52:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 17:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,404,1574150400"; 
   d="gz'50?scan'50,208,50";a="311229129"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2020 17:52:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iz9rd-000BCP-Ll; Wed, 05 Feb 2020 09:52:25 +0800
Date:   Wed, 5 Feb 2020 09:51:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/46] libata: move ata_dump_id() to dynamic debugging
Message-ID: <202002050952.2bQ21sJQ%lkp@intel.com>
References: <20200204165547.115220-10-hare@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6xk2ku44mh4u3rux"
Content-Disposition: inline
In-Reply-To: <20200204165547.115220-10-hare@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--6xk2ku44mh4u3rux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hannes,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on v5.5]
[cannot apply to block/for-next next-20200204]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Hannes-Reinecke/ata-kill-ATA_DEBUG/20200205-040548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 0cc4bd8f70d1ea2940295f1050508c663fe9eff9
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/spi/spi.h:207: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   include/linux/spi/spi.h:650: warning: Function parameter or member 'irq_flags' not described in 'spi_controller'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:254: warning: Function parameter or member 'hdcp_workqueue' not described in 'amdgpu_display_manager'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   sound/soc/soc-core.c:2522: warning: Function parameter or member 'legacy_dai_naming' not described in 'snd_soc_register_dai'
   drivers/infiniband/core/umem_odp.c:167: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_alloc_child'
   drivers/infiniband/core/umem_odp.c:217: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_get'
   drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
   drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd0' not described in 'opa_vesw_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd1' not described in 'opa_vesw_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd2' not described in 'opa_vesw_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd3' not described in 'opa_vesw_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd4' not described in 'opa_vesw_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd0' not described in 'opa_per_veswport_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd1' not described in 'opa_per_veswport_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd2' not described in 'opa_per_veswport_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd3' not described in 'opa_per_veswport_info'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:263: warning: Function parameter or member 'tbl_entries' not described in 'opa_veswport_mactable'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function parameter or member 'reserved' not described in 'opa_veswport_summary_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd0' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd1' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd2' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd3' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd4' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd5' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd6' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd7' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd8' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd9' not described in 'opa_veswport_error_counters'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:460: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:485: warning: Function parameter or member 'reserved' not described in 'opa_vnic_notice_attr'
   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:500: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad_trap'
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
>> drivers/ata/libata-core.c:1454: warning: Function parameter or member 'ap' not described in 'ata_dump_id'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:232: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:232: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:514: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:514: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2459: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2459: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2459: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   net/core/skbuff.c:5489: warning: Function parameter or member 'ethernet' not described in 'skb_mpls_push'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2082: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
   include/net/cfg80211.h:1189: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
   include/net/mac80211.h:4081: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
   include/net/mac80211.h:2036: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
   include/linux/devfreq.h:187: warning: Function parameter or member 'last_status' not described in 'devfreq'
   drivers/devfreq/devfreq.c:1818: warning: bad line: - Resource-managed devfreq_register_notifier()
   drivers/devfreq/devfreq.c:1854: warning: bad line: - Resource-managed devfreq_unregister_notifier()
   drivers/devfreq/devfreq-event.c:355: warning: Function parameter or member 'edev' not described in 'devfreq_event_remove_edev'
   drivers/devfreq/devfreq-event.c:355: warning: Excess function parameter 'dev' description in 'devfreq_event_remove_edev'
   Documentation/admin-guide/hw-vuln/tsx_async_abort.rst:142: WARNING: duplicate label virt_mechanism, other instance in Documentation/admin-guide/hw-vuln/mds.rst
   Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
   Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
   include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
   drivers/firewire/core-transaction.c:606: WARNING: Inline strong start-string without end-string.
   Documentation/x86/boot.rst:72: WARNING: Malformed table.
   Text in column margin in table line 57.

vim +1454 drivers/ata/libata-core.c

  1440	
  1441	/**
  1442	 *	ata_dump_id - IDENTIFY DEVICE info debugging output
  1443	 *	@id: IDENTIFY DEVICE page to dump
  1444	 *
  1445	 *	Dump selected 16-bit words from the given IDENTIFY DEVICE
  1446	 *	page.
  1447	 *
  1448	 *	LOCKING:
  1449	 *	caller.
  1450	 */
  1451	
  1452	static inline void ata_dump_id(struct ata_port *ap, const u16 *id)
  1453	{
> 1454		ata_port_dbg(ap,
  1455			"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
  1456			"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
  1457			"88==0x%04x  93==0x%04x\n",
  1458			id[49], id[53], id[63], id[64], id[75], id[80],
  1459			id[81], id[82], id[83], id[84], id[88], id[93]);
  1460	}
  1461	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--6xk2ku44mh4u3rux
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6xk2ku44mh4u3rux--
